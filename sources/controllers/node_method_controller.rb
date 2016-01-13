namespace '/node_methods' do
  get do
    @node_methods = NodeMethod.all()
    json :node_method => @node_methods
  end

  post do
    NodeMethod.create!(params[:node_method])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @node_method = NodeMethod.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @node_method.delete
    end

    patch do
      @node_method.assign_attributes(params[:node_method]).save!
      json :node_method => @node_method
    end

    get do
      json :node_method => @node_method
    end
  end
end
