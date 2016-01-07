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
  get '/new' do             #
    @node = Node.new        # dafuq is this
    haml :node              #
  end                       #

  post '/' do               #
    Node.new(params[:node]) # dafuq is that
  end                       #

  before %r{\A/(?<id>\d+)/?.*} do
    @node = Node.find(params[:id])
  end

  namespace '/:id' do

    delete do
      @node.delete
    end

    put do
      # how do we update all provided params?
        # there must be a way
      # remove id, than pass hash to node.update()?
        # doesn't sound THAT great, .assign_attributes might be a good choice?
      redirect to("/nodes/#{@node.id}")
    end

    get do
      haml :node
    end
  end
end
