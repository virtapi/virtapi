namespace '/domains' do
  get do
    @domain = Domain.all()
    json :domain => @domains
  end

  post do
    Domain.create!(params[:domain])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @domain = Domain.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @domain.delete
    end

    patch do
      @domain.assign_attributes(params[:domain]).save!
      redirect to("/domains/#{@domain.id}")
    end

    get do
      json :domain => @domain
    end
  end
end
