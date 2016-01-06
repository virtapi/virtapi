class NodeController < Sinatra::Base
  set :views, File.expand_path('../../views', __FILE__)

  get '/' do
    @nodes = Node.all
    haml :nodes
  end

  # html view, sends stuff to /node as POST
  get '/new' do
    @node = Node.new
    haml :node
  end

  post '/' do
    Node.new(params[:node])
  end

  delete '/:id' do
    Node.delete(params[:id])
  end

  put '/:id' do
    @node = Node.find(params[:id])
    # how do we update all provided params?
    # remove id, than pass hash to node.update()?
    redirect to("/nodes/#{node.id}")
  end

  get '/:id' do
    @node = Node.find(params[:id])
    haml :node
  end
end
