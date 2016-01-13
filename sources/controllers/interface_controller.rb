namespace '/interfaces' do
  get do
    return_resource object: Interface.all()
  end

  post do
    return_resource object: Interface.create!(params[:interface])
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
