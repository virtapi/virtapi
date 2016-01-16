namespace '/storages' do
  get do
    @storages = Storage.all
    return_resource object: @storages
  end

  post do
    @storage = Storage.create!(params[:storage])
    return_resource object: @storage
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @storage = Storage.find(params[:id])
  end

  namespace '/:id' do
    delete do
      return_resource object: @storage.delete
    end

    patch do
      @storage.assign_attributes(params[:storage]).save!
      return_resource object: @storage
    end

    get do
      return_resource object: @storage
    end
  end
end
