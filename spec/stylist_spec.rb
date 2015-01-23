require('spec_helper.rb')

describe(Stylist) do
  describe(".all") do
    it("starts off with no stylists") do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe('#name') do
    it("tells you the stylist's name") do
      test_stylist = Stylist.new({:name => "Charlene", :id => nil})
      expect(test_stylist.name()).to(eq("Charlene"))
    end
  end

  describe("#id") do
    it("sets the stylists ID when you save it") do
      test_stylist = Stylist.new({:name => "Charlene", :id => nil})
      test_stylist.save()
      expect(test_stylist.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save stylists to the database") do
      test_stylist = Stylist.new({:name => "Charlene", :id => nil})
      test_stylist.save()
      expect(Stylist.all()).to(eq([test_stylist]))
    end
  end

  describe("#clients") do
    it('returns an empty array if you ask for a new, clientless stylist') do
      test_stylist = Stylist.new({:name => "Charlene", :id => nil})
      test_stylist.save()
      expect(test_stylist.clients()).to(eq([]))
    end

    it('returns all the client objects for a given stylist by the stylists id number') do
      test_stylist = Stylist.new({:name => "Charlene", :id => nil})
      test_stylist.save()
      test_task = Task.new({:id => nil, :name => "Marge Simpson", :phone => "503-555-1212", :stylist_id => test_stylist.id() })
      test_task.save()
      test_task2 = Task.new({:id => nil, :name => "Maude Flanders", :phone => "503-555-1234", :stylist_id => test_stylist.id() })
      test_task2.save()
      expect(test_stylist.clients()).to(eq([test_task2, test_task]))
    end
  end

  describe("#==") do
    it("is the same stylist if it has the same name and id") do
      test_stylist1 = Stylist.new({:name => "Charlene", :id => nil})
      test_stylist2 = Stylist.new({:name => "Charlene", :id => nil})
      expect(test_stylist1).to(eq(test_stylist2))
    end
  end

end
