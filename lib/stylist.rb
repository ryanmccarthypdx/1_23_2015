# require('client')

class Stylist
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      name = stylist.fetch("name")
      id = stylist.fetch("id").to_i()
      stylists.push(Stylist.new({:name => name, :id => id}))
    end
    stylists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:clients) do
    returned_clients = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id()} ORDER BY name;")
    clients = []
    returned_clients.each() do |client|
      name = client.fetch("name")
      stylist_id = client.fetch("stylist_id").to_i()
      phone = client.fetch("phone")
      recreated_client = (Client.new({:name => name, :stylist_id => stylist_id, :phone => phone}))
      clients.push(recreated_client)
    end
    clients
  end

  define_singleton_method(:find) do |find_id|
    select_result = DB.exec("SELECT * FROM stylists WHERE id = #{find_id};")
    name = select_result.first().fetch("name")
    Stylist.new({ :name => name, :id => find_id})
  end


  define_method(:==) do |another_stylist|
    self.name().==(another_stylist.name()).&(self.id().==(another_stylist.id()))
  end
end
