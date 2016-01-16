namespace '/ipv6s' do
  get do
    return_resource object: Ipv6.all
  end

  post do
    return_resource object: Ipv6.create!(params[:ipv6])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @ipv6 = Ipv6.find(params[:id])
  end

  namespace '/:id' do
    delete do
      return_resource object: @ipv6.delete
    end

    patch do
      @ipv6.assign_attributes(params[:ipv6]).save!
      return_resource object: @ipv6
    end

    get do
      return_resource object: @ipv6
    end
  end
end
