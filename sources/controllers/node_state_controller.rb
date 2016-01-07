namespace '/node_states' do
  get do
    @node_states = NodeState.all()
    json :node_state => @node_states
  end

  post do
    NodeState.create!(params[:node_state])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @node_state = NodeState.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @node_state.delete
    end

    patch do
      @node_state.assign_attributes(params[:node_state]).save!
      redirect to("/node_states/#{@node_state.id}")
    end

    get do
      json :node_state => @node_state
    end
  end
end
