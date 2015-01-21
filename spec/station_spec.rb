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

  describe(".find_by_id") do
    it("returns a station when you input an id") do
      test_station = Station.new({:name => "Abbotsville", :id => nil})
      test_station.save()
      test_station_id = test_station.id()
      expect(Station.find_by_id(test_station_id)).to(eq(test_station))
    end
  end

  describe("#associate") do
    it("associates lines with the given station (ie, it creates stops)") do
      test_station = Station.new({:name => "Abbotsville", :id => nil})
      test_station.save()
      test_line1 = Line.new({:name => "Green", :id => nil})
      test_line1.save()
      tl1n = test_line1.name()
      test_line2 = Line.new({:name => "Red", :id => nil})
      test_line2.save()
      tl2n = test_line2.name()
      test_station.associate([tl1n, tl2n])
      expect(test_station.lines()).to(eq([test_line1, test_line2]))
    end
  end
end
