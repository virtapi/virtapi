namespace '/domains' do
  get do
    @nodes = Domain.all() # wat
    erb :index
  end

  post do
    # how do we provide post data from the request to the .new()?
      # puuuh man, dunno. ask your node friend
    Domain.new()
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @domain = Domain.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @domain.delete
    end

    patch do
      @domain.try(:patch_the_shit_out_of_me) || :nope
    end

    get do
      @domain.to_json
    end
  end
end
