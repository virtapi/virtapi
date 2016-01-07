namespace '/domains' do
  get do
    @nodes = Domain.all()
    json :node => @nodes
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
      json :node => @node
    end
  end
end
