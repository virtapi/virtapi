namespace '/interfaces' do
  get do
    @interfaces = Interface.all()
    json :interface => @interfaces
  end

  post do
    Interface.create!(params[:interface])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @interface = Interface.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @interface.delete
    end

    patch do
      @interface.assign_attributes(params[:interface]).save!
      redirect to("/interfaces/#{@interface.id}")
    end

    get do
      json :interface => @interface
    end
  end
end
