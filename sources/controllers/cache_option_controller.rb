namespace '/cache_options' do
  get do
    @cache_options = CacheOption.all()
    json :cache_option => @cache_options
  end

  post do
    CacheOption.create!(params[:cache_option])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @cache_option = CacheOption.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @cache_option.delete
    end

    patch do
      @cache_option.assign_attributes(params[:cache_option]).save!
      json :cache_option => @cache_options
    end

    get do
      json :cache_option => @cache_options
    end
  end
end
