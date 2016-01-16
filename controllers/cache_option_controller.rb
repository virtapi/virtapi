namespace '/cache_options' do
  get do
    @cache_options = CacheOption.all
    return_resource object: @cache_options
  end

  post do
    @cache_option = CacheOption.create!(params[:cache_option])
    return_resource object: @cache_option
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
      return_resource object: @cache_option
    end

    get do
      return_resource object: @cache_option
    end
  end
end
