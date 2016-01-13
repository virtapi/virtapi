namespace '/virt_methods' do
  get do
    @virt_methods = VirtMethod.all()
    json :virt_method => @virt_methods
  end

  post do
    VirtMethod.create!(params[:virt_method])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @virt_method = VirtMethod.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @virt_method.delete
    end

    patch do
      @virt_method.assign_attributes(params[:virt_method]).save!
      json :virt_method => @virt_method
    end

    get do
      json :virt_method => @virt_method
    end
  end
end
