namespace '/nodes' do
  get do
    return_resource object: Node.all
  end

  post do
    return_resource object: Node.create!(params[:node])
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
