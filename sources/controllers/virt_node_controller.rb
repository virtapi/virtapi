namespace '/virt_nodes' do
  get do
    return_resource object: VirtNpde.all
  end

  post do
    return_resource object: VirtNode.create!(params[:virt_node])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @virt_node = VirtNode.find(params[:id])
  end

  namespace '/:id' do
    delete do
      return_resource object: @virt_node.delete
    end

    patch do
      @virt_node.assign_attributes(params[:virt_node]).save!
      return_resource object: @virt_node
    end

    get do
      return_resource object: @virt_node
    end
  end
end
