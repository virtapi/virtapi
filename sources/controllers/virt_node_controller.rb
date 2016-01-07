namespace '/virt_nodes' do
  get do
    @virt_nodes = VirtNpde.all()
    json :virt_node => @virt_node
  end

  post do
    VirtNode.create!(params[:virt_node])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @virt_node = VirtNode.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @virt_node.delete
    end

    patch do
      @virt_node.assign_attributes(params[:virt_node]).save!
      redirect to("/virt_node/#{@virt_node.id}")
    end

    get do
      json :virt_node => @virt_node
    end
  end
end
