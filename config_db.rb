# configure the database
require './adapter_redis'

a = Adapter.new
a.create_db
