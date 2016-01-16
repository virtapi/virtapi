namespace '/interfaces' do
  get do
    @interfaces = Interface.all
    return_resource object: @interfaces
  end

  post do
    @interface = Interface.create!(params[:interface])
    return_resource object: @interface
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @interface = Interface.find(params[:id])
  end

  namespace '/:id' do
    delete do
      return_resource object: @interface.delete
    end

    patch do
      @interface.assign_attributes(params[:interface]).save!
      return_resource object: @interface
    end

    get do
      return_resource object: @interface
    end
  end
end
