namespace '/ipv6s' do
  get do
    @ipv6s = Ipv6.all()
    json :ipv6 => @ipv6s
  end

  post do
    Ipv6.create!(params[:ipv6])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @ipv6 = Ipv6.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @ipv6.delete
    end

    patch do
      @ipv6.assign_attributes(params[:ipv6]).save!
      redirect to("/ipv6s/#{@ipv6.id}")
    end

    get do
      json :ipv6 => @ipv6
    end
  end
end
