namespace '/domain_states' do
  get do
    @domain_states = DomainState.all()
    json :domain_states => @domain_states
  end

  post do
    DomainState.create!(params[:domain_state])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @domain_state = DomainState.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @domain_state.delete
    end

    patch do
      @domain_state.assign_attributes(params[:domain_state]).save!
      redirect to("/domain_states/#{@domain_state.id}")
    end

    get do
      json :node_state => @node_state
    end
  end
end
