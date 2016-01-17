module PuppetdbHelper
  def initialize
    @api = settings.puppet
    @con = puppetdb_api_connect
  end

  def api_connect
    uri = URI.parse(@api[:api_url])
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    if @api[:api_ca]
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http.cert_store = OpenSSL::X509::Store.new
      http.cert_store.set_default_paths
      http.cert_store.add_file(@api[:api_ca])
    end
    http
  end

  def get_fact_value_from_node(fact)
    # TODO: how do we refer to the fqdn attribute of the class that includes this module?
    uri = URI.parse("#{@api[:api_url]}/#{@api[:api_version]}/#{@api[:api_node]}/#{fqdn}/facts/#{fact}")
    res = con.request(Net::HTTP::Get.new(uri.request_uri))
    JSON.load(res.body)[0].to_h.any? ? JSON.load(res.body)[0]['value'] : nil
  end

  def get_ipmi_ip(force: nil)
    @host_ipmi_ip = nil if force
    @host_ipmi_ip ||= get_fact_value_from_node('bmc_ip')
  end

  def get_productname(force: nil)
    @host_productname = nil if force
    @host_productname ||= get_fact_value_from_node('productname')
  end

  def get_all_nodes # rubocop:disable Style/AccessorMethodName
    uri = URI.parse("#{@api[:api_url]}/#{@api[:api_version]}/#{@api[:api_node]}/")
    res = @puppet_api.request(Net::HTTP::Get.new(uri.request_uri))
    JSON.load(res.body).map { |node| node['name'] }
  end
end
