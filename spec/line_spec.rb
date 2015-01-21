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

  describe(".find_by_id") do
    it("returns a line when you input an id") do
      test_line = Line.new({:name => "Green", :id => nil})
      test_line.save()
      test_line_id = test_line.id()
      expect(Line.find_by_id(test_line_id)).to(eq(test_line))
    end
  end

  describe("#associate") do
    it("associates stations with the given line (ie, it creates stops)") do
      test_line = Line.new({:name => "Green", :id => nil})
      test_line.save()
      test_station1 = Station.new({:name => "Abbotsville", :id => nil})
      test_station1.save()
      ts1n = test_station1.name()
      test_station2 = Station.new({:name => "Barrytown", :id => nil})
      test_station2.save()
      ts2n = test_station2.name()
      test_line.associate([ts1n, ts2n])
      expect(test_line.stations()).to(eq([test_station1, test_station2]))
    end
  end
end
