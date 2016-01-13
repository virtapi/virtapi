namespace '/ipv4s' do
  get do
    @ipv4s = Ipv4.all()
    json ipv4: @ipv4s
  end

  post do
    json ipv4: Ipv4.create!(params[:ipv4])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @ipv4 = Ipv4.find(params[:id])
  end

  namespace '/:id' do
    delete do
      json ipv4: @ipv4.delete
    end

    patch do
      @ipv4.assign_attributes(params[:ipv4]).save!
      resource
    end

    get do
      resource
    end
  end

private

  def resource as_json: true
    as_json ? json(ipv4: @ipv4) : @ipv4
  end

end
