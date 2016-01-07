namespace '/domains' do
  get do
    @nodes = Domain.all() # wat
    erb :index
  end

  post do
    Domain.create!(params[:domain]) # this will raise
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @domain = Domain.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @domain.delete
    end

    patch do
      @domain.assign_attributes(params[:domain]).save! # this will raise
    end

    get do
    end
  end
end
