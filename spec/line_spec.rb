require('rspec')
require('line')
require('station')
require('pg')


DB = PG.connect({:dbname => 'train_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lines *;")
    DB.exec("DELETE FROM stations *;")
  end
end


describe(Line) do
  describe(".all") do
    it("starts off with no Lines") do
      expect(Line.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("lets you save a line to the database") do
      line = Line.new({:name => "Green", :id => nil})
      line.save()
      expect(Line.all()).to(eq([line]))
    end
  end

  describe(".find") do
    it("returns a line when you input an id") do
      test_line = Line.new({:name => "Green", :id => nil})
      test_line.save()
      test_line_id = test_line.id()
      expect(Line.find(test_line_id)).to(eq(test_line))
    end
  end

  describe("#associate") do
    it("associates stations with the given line (ie, it creates stops)") do
      test_line = Line.new({:name => "Green", :id => nil})
      test_line.save()
      test_line_id = test_line.id()
      test_station1 = Station.new({:name => "Abbotsville", :id => nil})
      test_station1.save()
      test_station1_id = test_station1.id()
      test_station2 = Station.new({:name => "Barrytown", :id => nil})
      test_station2.save()
      test_station2_id = test_station2.id()
      test_line.associate(test_station1)
      test_line.associate(test_station2)
      expect(test_line.stations()).to(eq([test_station1, test_station2]))
    end
  end


  # describe("#stations") do
  #   it("return all stations by line name") do
  #     test_line = Line.new({:name => "Black", :id => nil})
  #     test_line.save()
  #     test_line_id = test_line.id()
  #     test_station = Station.new({:name => "Abbotsville", :id => nil})
  #     test_station.save()
  #     test_station_id = test_station.id()
  #













end
