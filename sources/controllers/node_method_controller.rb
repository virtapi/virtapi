namespace '/node_methods' do
  get do
    return_resource object: NodeMethod.all()
  end

  post do
    return_resource object: NodeMethod.create!(params[:node_method])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @node_method = NodeMethod.find(params[:id])
  end

  namespace '/:id' do
    delete do
      return_resource object: @node_method.delete
    end

    patch do
      @node_method.assign_attributes(params[:node_method]).save!
      return_resource object: @node_method
    end

    get do
      return_resource object: @node_method
    end
  end
end
