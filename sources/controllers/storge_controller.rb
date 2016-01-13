namespace '/storages' do
  get do
    @storages = Storage.all()
    json :storage => @storages
  end

  post do
    Storage.create!(params[:storage])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @storage = Storage.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @storage.delete
    end

    patch do
      @storage.assign_attributes(params[:storage]).save!
      json :storage => @storage
    end

    get do
      json :storage => @storage
    end
  end
end
