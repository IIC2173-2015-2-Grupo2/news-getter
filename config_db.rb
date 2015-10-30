# configure the database
require './adapter'

a = Adapter.new
a.create_db
