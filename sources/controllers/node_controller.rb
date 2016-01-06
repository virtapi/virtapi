class NodeController < Sinatra::Base
  require 'sinatra/contrib'
  set :views, File.expand_path('../../views', __FILE__)

  get '/', :provides => [:html, :json] do
    @nodes = Node.all
    respond_to do |type|
      type.html { haml :nodes }
      type.json {json :nodes => @nodes }
    end
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
