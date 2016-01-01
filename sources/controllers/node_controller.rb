class NodeController < Sinatra::Base

  set :views, File.expand_path('../../views', __FILE__)

  get '/' do
    @nodes = Node.all()
    'zomg it wörks'
  end

  post '/' do
    # how do we provide post data from the request to the .new()?
    Node.new()
  end

  delete '/:id' do
    Node.delete(params[:id])
  end

  patch '/:id' do
   #uhm yeah...
  end

  get '/hello' do
    #puts 'hello world'
    erb :home
  end
  
  get '/:id' do
    Node.find(params[:id])
  end

end
