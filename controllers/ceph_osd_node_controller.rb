namespace '/ceph_osd_nodes' do
  get do
    @ceph_osd_nodes = CephOsdNode.all
    return_resource object: @ceph_osd_nodes
  end

  post do
    @ceph_osd_node = CephOsdNode.create!(params[:ceph_osd_node])
    return_resource object: @ceph_osd_node
  end

  before %r{\A/(?<id>\d+)/?.*} do
    @ceph_mon_node = CephOsdNode.find(params[:id])
  end

  namespace '/:id' do
    delete do
      return_resource object: @ceph_osd_node.delete
    end

    patch do
      @ceph_osd_node.assign_attributes(params[:ceph_osd_node]).save!
      return_resource object: @ceph_osd_node
    end

    get do
      return_resource object: @ceph_osd_node
    end
  end
end
