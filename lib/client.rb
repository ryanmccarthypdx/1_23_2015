class Client
  attr_reader(:name, :stylist_id, :phone)

  define_method(:initialize) do |attribute|
    @name = attribute.fetch(:name)
    @stylist_id = attribute.fetch(:stylist_id)
    @phone = attribute.fetch(:phone)
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      name = client.fetch("name")
      stylist_id = client.fetch("stylist_id").to_i()
      phone = client.fetch("phone")
      clients.push(Client.new({:name => name, :stylist_id => stylist_id, :phone => phone}))
    end
    clients
  end

  define_method(:save) do
    DB.exec("INSERT INTO clients (name, stylist_id, phone) VALUES ('#{@name}', #{@stylist_id}, '#{@phone}')")
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM clients *;")
  end

  define_method(:==) do |another_task|
    self.name().==(another_task.name()).&(self.stylist_id().==(another_task.stylist_id()))
  end

end
