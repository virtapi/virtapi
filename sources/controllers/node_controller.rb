set :views, File.expand_path('../../views', __FILE__)
namespace '/nodes' do
  get '', :provides => [:html, :json] do
    @nodes = Node.all
    respond_to do |type|
      type.html { haml :nodes }
      type.json {json :nodes => @nodes }
    end
  end

  # html view, sends stuff to /node as POST
  post '/' do
    Node.new(params[:node])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @node = Node.find(params[:id])
  end

  namespace '/:id' do

    delete do
      @node.delete
    end

    put do
      @node.assign_attributes(params[:node]).save! #this will raise on error
      redirect to("/nodes/#{@node.id}")
    end

    get do
      haml :node
    end
  end
end
