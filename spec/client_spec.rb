require('spec_helper')

describe(Client) do
  describe("#name") do
    it("lets you give it a name") do
      test_client = Client.new({:name => "Marge Simpson", :stylist_id => 1, :phone => "503-555-1212"})
      expect(test_client.name()).to(eq("Marge Simpson"))
    end
  end

  describe(".all") do
    it("is empty at first") do
    expect(Client.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a client to the array of saved clients") do
    test_client = Client.new({:name => "Marge Simpson", :stylist_id => 1, :phone => "503-555-1212"})
    test_client.save()
    expect(Client.all()).to(eq([test_client]))
    end
  end

  describe(".clear") do
    it("empties all the saved clients") do
      Client.new({:name => "Marge Simpson", :stylist_id => 1, :phone => "503-555-1212"}).save()
      Client.clear()
      expect(Client.all()).to(eq([]))
    end
  end

  describe("#stylist_id") do
    it("lets you read the stylist ID out") do
      test_client = Client.new({:name => "Marge Simpson", :stylist_id => 1, :phone => "503-555-1212"})
      expect(test_client.stylist_id()).to(eq(1))
    end
  end

  describe("#phone") do
    it("lets you read the clients phone number") do
      test_client = Client.new({:name => "Marge Simpson", :stylist_id => 1, :phone => "503-555-1212"})
      expect(test_client.phone()).to(eq("503-555-1212"))
    end
  end

  describe("#==") do
    it("is the same client if he/she has the same name and id") do
      client1 = Client.new({:name => "Marge Simpson", :stylist_id => 1, :phone => "503-555-1212" })
      client2 = Client.new({:name => "Marge Simpson", :stylist_id => 1, :phone => "503-555-1212" })
      expect(client1).to(eq(client2))
    end
  end

  # before() do
  #   Client.clear()
  # end
  #   ABSOLUTE GENIUS IF YOU ASK ME!

end
