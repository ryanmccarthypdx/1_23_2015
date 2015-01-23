require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/stylist')
require('./lib/client')
require('pg')

DB = PG.connect({:dbname => "salon"})

get('/') do
  @list_of_stylists = Stylist.all()
  erb(:main)
end

post('/stylist_post') do
  @name = params.fetch("stylist_name")
  new_stylist = Stylist.new({:id => nil, :name => @name})
  new_stylist.save()
  @list_of_stylists = Stylist.all()
  erb(:main)
end

post('/client_post') do
  @name = params.fetch("client_name")
  @phone = params.fetch("phone").to_s()
  @stylist_id = params.fetch("stylist_id")
  new_client = Client.new({:id => nil, :name => @name, :phone => @phone, :stylist_id => @stylist_id})
  new_client.save
  @list_of_stylists = Stylist.all()
  erb(:main)
end
