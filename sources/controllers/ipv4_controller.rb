namespace '/ipv4s' do
  get do
    @ipv4s = Ipv4.all
    return_resource object: @ipv4s
  end

  post do
    return_resource object: Ipv4.create!(params[:ipv4])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @ipv4 = Ipv4.find(params[:id])
  end

  namespace '/:id' do
    delete do
      return_resource object: @ipv4.delete
    end

    patch do
      @ipv4.assign_attributes(params[:ipv4]).save!
      return_resource object: @ipv4
    end

    get do
      return_resource object: @ipv4
    end
  end
end
