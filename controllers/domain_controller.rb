namespace '/domains' do
  get do
    @domains = Domain.all
    return_resource object: @domains
  end

  post do
    @domain = Domain.create!(params[:domain])
    return_resource object: @domain
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @domain = Domain.find(params[:id])
  end

  namespace '/:id' do
    delete do
      return_resource object: @domain.delete
    end

    patch do
      @domain.assign_attributes(params[:domain]).save!
      return_resource object: @domain
    end

    get do
      return_resource object: @domain
    end
  end
end
