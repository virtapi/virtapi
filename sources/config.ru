require './virtapi_app.rb'
map('/node') { run NodeController }
map('/domain') { run DomainController }
#map('/storage') { run StorageController }
#map('/ipv4') { run Ipv4Controller }
#map('/ipv6') { run Ipv6Controller }
#map('/interface') { run InterfaceController }
run Sinatra::Application
