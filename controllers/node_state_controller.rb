namespace '/node_states' do
  get do
    return_resource object: NodeState.all
  end

  post do
    return_resource object: NodeState.create!(params[:node_state])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @node_state = NodeState.find(params[:id])
  end

  namespace '/:id' do
    delete do
      return_resource object: @node_state.delete
    end

    patch do
      @node_state.assign_attributes(params[:node_state]).save!
      return_resource object: @node_state
    end

    get do
      return_resource object: @node_state
    end
  end
end
