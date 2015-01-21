require('rspec')
require('line')
require('pg')
require('station')

DB = PG.connect({:dbname => 'train_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lines *;")
    DB.exec("DELETE FROM stations *;")
  end
end

describe(Station) do

  describe(".all") do
    it("starts off with no Stations") do
      expect(Station.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("lets you save a station to the database") do
      station = Station.new({:name => "Abbotsville", :id => nil})
      station.save()
      expect(Station.all()).to(eq([station]))
    end
  end

  describe(".find") do
    it("returns a station when you input an id") do
      test_station = Station.new({:name => "Abbotsville", :id => nil})
      test_station.save()
      test_station_id = test_station.id()
      expect(Station.find(test_station_id)).to(eq(test_station))
    end
  end



end
