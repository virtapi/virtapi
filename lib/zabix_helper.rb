module ZabbixHelper
  def initialize
    @api = settings.zabbix
    @con = zbx_api_connect
    get_ipmi_ip
  end

  def zbx_api_connect
    ZabbixApi.connect(
      url:      @api[:api_url],
      user:     @api[:api_user],
      password: @api[:api_pw]
    )
  end

  def get_zbx_host_id(force: nil)
    @zbx_host_id = nil if force
    @zbx_host_id ||= @con.hosts.get_id(host: fqdn)
  end

  def add_snmp_interface(beautiful = true)
    if @host_ipmi_ip
      puts "configuring snmp interface #{@host_ipmi_ip} from host #{@host}"
      if beautiful
        add_interface(@zbx_host_id, @host_ipmi_ip, @zbx_interface_type[:snmp], @snmp_port)
      else
        query_interface_create(@zbx_interface_type[:snmp], @snmp_port)
      end
    else
      puts "\@host_ipmi_ip is empty on node #{@host}, please fix that"
    end
  end

  def add_ipmi_interface(beautiful = true)
    if @host_ipmi_ip
      puts "configuring ipmi interface #{@host_ipmi_ip} from host #{@host}"
      if beautiful
        add_interface(@zbx_host_id, @host_ipmi_ip, @zbx_interface_type[:ipmi], @ipmi_port)
      else
        query_interface_create(@zbx_interface_type[:ipmi], @ipmi_port)
      end
    else
      puts "\@host_ipmi_ip is empty on node #{@host}, please fix that"
    end
  end

  def check_if_snmp_is_possible
    @drac7.include? get_ipmi_ip
  end

  def enable_snmp_template
    return false unless check_if_snmp_is_possible
    zbx_link_template(@zbx_host_id, '19814')
    puts "added template '19814' to node #{@host}"
  end

  def enable_ipmi_template
    # zbx_link_template(@zbx_host_id, )
    puts 'please provide the id of the template!'
  end

  def add_interface(zbx_host_id, ip, interface_id, port)
    @zbx_api.hosts.update(hostid: zbx_host_id,
                          interfaces: [
                            {
                              type: interface_id,
                              main: 1,
                              ip: ip,
                              dns: '',
                              port: port,
                              useip: 1
                            }
                          ])
  end

  def zbx_link_template(zbx_host_id, template_id)
    #  @zbx_api.hosts.update({
    #    hostid: zbx_host_id,
    #    templates: [
    #      templateid: template_id
    #    ]
    #  }) unless zbx_check_if_template_is_linked template_id
    if zbx_check_if_template_is_linked template_id
      puts "template #{template_id} already linked at #{@host}"
    else
      ids = zbx_get_linked_templates << template_id
      ids.map! { |id| { templateid: id } }
      params = {
        hostid: zbx_host_id,
        templates: ids
      }
      query_zbx_api('host.update', params) # unless zbx_check_if_template_is_linked template_id
    end
  end

  def zbx_get_linked_templates
    @zbx_api.templates.get_ids_by_host(hostids: @zbx_host_id)
  end

  def zbx_check_if_template_is_linked(template_id)
    zbx_get_linked_templates.include? template_id
  end

  def query_zbx_api(method, params)
    if params.is_a? Hash
      begin
        @zbx_api.query(
          method: method,
          params: params
        )
      rescue ZabbixApi::ApiError => e
        if e.message =~ /Host cannot have more than one default interface/
          puts 'interface already configured'
        else
          puts e.message
        end
      end
    else
      puts 'params has to be a Hash'
    end
  end

  def query_interface_create(type, port)
    if @host_ipmi_ip
      params = {
        hostid: @zbx_host_id,
        dns: '',
        ip: @host_ipmi_ip,
        main: 1,
        port: port,
        type: type,
        useip: 1
      }
      query_zbx_api('hostinterface.create', params)
    else
      puts "\@host_ipmi_ip is empty on node #{@host}, please fix that"
    end
  end
end
