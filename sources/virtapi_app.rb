require 'sinatra'
require 'sinatra/base'
require 'sinatra/contrib'
require 'haml'
require 'json'
require 'sinatra/logger'
require 'active_record'

Dir.glob('./{models,controllers}/*.rb').each { |file| require file }

ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: "#{__dir__}/dbfile.sqlite")

before /.*/ do
  if request.path_info.match(/.json$/)
    content_type :json, 'charset' => 'utf-8'
    request.accept.unshift('application/json')
    request.path_info = request.path_info.gsub(/.json$/,'')
  else
    content_type :html, 'charset' => 'utf-8'
  end
end


