namespace '/domain_states' do
  get do
    @domain_states = DomainState.all
    return_resource object: @domain_states
  end

  post do
    @domain = DomainState.create!(params[:domain_state])
    return_resource object: @domain
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @domain_state = DomainState.find(params[:id])
  end

  namespace '/:id' do
    delete do
      return_resource object: @domain_state.delete
    end

    patch do
      @domain_state.assign_attributes(params[:domain_state]).save!
      return_resource object: @domain_state
    end

    get do
      return_resource object: @domain_state
    end
  end
end
