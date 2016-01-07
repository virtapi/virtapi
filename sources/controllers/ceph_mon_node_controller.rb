namespace '/ceph_mon_nodes' do
  get do
    @ceph_mon_nodes = CephMonNode.all()
    json :ceph_mon_node => @ceph_mon_nodes
  end

  post do
    CephMonNode.create!(params[:ceph_mon_node])
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @ceph_mon_node = CephMonNode.find(params[:id])
  end

  namespace '/:id' do
    delete do
      @ceph_mon_node.delete
    end

    patch do
      @ceph_mon_node.assign_attributes(params[:ceph_mon_node]).save!
      redirect to("/ceph_mon_nodes/#{@ceph_mon_node.id}")
    end

    get do
      json :ceph_mon_node => @ceph_mon_node
    end
  end
end
