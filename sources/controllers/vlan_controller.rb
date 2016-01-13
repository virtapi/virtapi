namespace '/vlans' do
  get do
    @vlans = Vlan.all()
    json :vlan => @vlans
  end

  post do
    Vlan.create!(params[:vlan])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @vlan = Vlan.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @vlan.delete
    end

    patch do
      @vlan.assign_attributes(params[:vlan]).save!
      json :vlan => @vlan
    end

    get do
      json :vlan => @vlan
    end
  end
end
