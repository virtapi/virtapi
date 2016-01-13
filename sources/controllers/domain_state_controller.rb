namespace '/domain_states' do
  get do
    return_resource object: DomainState.all()
  end

  post do
    return_resource object: DomainState.create!(params[:domain_state])
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
