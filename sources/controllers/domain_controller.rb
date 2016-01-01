class DomainController < Sinatra::Base

  get '/domain' do
    @nodes = Domain.all()
    erb :index
  end

  post '/domain' do
    # how do we provide post data from the request to the .new()?
    Domain.new()
  end

  delete '/domain/:id' do
    Domain.delete(params[:id])
  end

  patch '/domain/:id' do
   #uhm yeah...
  end

  get '/domain/:id' do
    Domain.find(params[:id])
  end

end
