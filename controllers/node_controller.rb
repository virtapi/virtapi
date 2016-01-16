namespace '/nodes' do
  get do
    @nodes = Node.all
    return_resource object: @nodes
  end

  post do
    @node = Node.create!(params[:node])
    return_resource object: @node
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @node = Node.find(params[:id])
  end

  namespace '/:id' do
    delete do
      return_resource object: @node.delete
    end

    put do
      @node.assign_attributes(params[:node]).save!
      return_resource object: @node
    end

    get do
      return_resource object: @node
    end
  end
end
