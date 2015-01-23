require('rspec')
require('stylist')
require('client')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'salon_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM stylists *;")
    DB.exec("DELETE FROM clients *;")
  end
end
