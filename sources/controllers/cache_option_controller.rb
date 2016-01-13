namespace '/cache_options' do
  get do
    return_resource object: CacheOption.all()
  end

  post do
    return_resource object: CacheOption.create!(params[:cache_option])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @cache_option = CacheOption.find(params[:id])
  end

  namespace '/:id' do
    delete do
      return_resource object: @cache_option.delete
    end

    patch do
      @cache_option.assign_attributes(params[:cache_option]).save!
      return_resource object: @cache_options
    end

    get do
     return_resource object: @cache_options
    end
  end
end
