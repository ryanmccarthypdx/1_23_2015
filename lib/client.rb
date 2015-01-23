class Client
  attr_reader(:id, :name, :stylist_id, :phone)

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
      id_num = client.fetch("id")
      clients.push(Client.new({:id => id_num, :name => name, :stylist_id => stylist_id, :phone => phone}))
    end
    clients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name, stylist_id, phone) VALUES ('#{@name}', #{@stylist_id}, '#{@phone}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM clients *;")
  end

  define_method(:==) do |another_client|
    self.name().==(another_client.name()).&(self.stylist_id().==(another_client.stylist_id()))
  end

end
