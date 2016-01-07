namespace '/storage_types' do
  get do
    @storage_types = StorageType.all()
    json :storage_types => @storage_types
  end

  post do
    StorageType.create!(params[:storage_type])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @storage_type = StorageType.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @storage_type.delete
    end

    patch do
      @storage_type.assign_attributes(params[:storage_type]).save!
      redirect to("/storage_types/#{@storage_type.id}")
    end

    get do
      json :storage_type => @storage_type
    end
  end
end
