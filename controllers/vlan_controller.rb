namespace '/vlans' do
  get do
    @vlans = Vlan.all
    return_resource object: @vlans
  end

  post do
    @vlan = Vlan.create!(params[:vlan])
    return_resource object: @vlan
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @vlan = Vlan.find(params[:id])
  end

  namespace '/:id' do
    delete do
      return_resource object: @vlan.delete
    end

    patch do
      @vlan.assign_attributes(params[:vlan]).save!
      return_resource object: @vlan
    end

    get do
      return_resource object: @vlan
    end
  end
end
