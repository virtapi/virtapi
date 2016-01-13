namespace '/nodes' do
  get do
    @nodes = Node.all
    json :nodes => @nodes
  end

  post do
    Node.create!(params[:node])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @node = Node.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @node.delete
    end

    put do
      @node.assign_attributes(params[:node]).save!
      json :node => @node
    end

    get do
      json :node => @node
    end
  end
end
