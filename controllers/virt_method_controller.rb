namespace '/virt_methods' do
  get do
    return_resource object: VirtMethod.all
  end

  post do
    return_resource object: VirtMethod.create!(params[:virt_method])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @virt_method = VirtMethod.find(params[:id])
  end

  namespace '/:id' do
    delete do
      return_resource object: @virt_method.delete
    end

    patch do
      @virt_method.assign_attributes(params[:virt_method]).save!
      return_resource object: @virt_method
    end

    get do
      return_resource object: @virt_method
    end
  end
end
