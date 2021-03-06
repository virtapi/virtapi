namespace '/storage_types' do
  get do
    @storage_types = StorageType.all
    return_resource object: @storage_types
  end

  post do
    @storage_type = StorageType.create!(params[:storage_type])
    return_resource object: @storage_type
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @storage_type = StorageType.find(params[:id])
  end

  namespace '/:id' do
    delete do
      return_resource object: @storage_type.delete
    end

    patch do
      @storage_type.assign_attributes(params[:storage_type]).save!
      return_resource object: @storage_type
    end

    get do
      return_resource object: @storage_type
    end
  end
end
