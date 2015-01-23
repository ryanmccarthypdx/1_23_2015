# require('client')
require('pry')



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
      due_date = client.fetch("due_date")
      recreated_task = (Task.new({:name => name, :stylist_id => stylist_id, :due_date => due_date}))
      clients.push(recreated_task)
    end
    clients
  end

  define_singleton_method(:sel) do |id|
    selection = []
    select_result = DB.exec("SELECT * FROM stylists WHERE id = #{id};")
    select_result.each() do |result| #even though i know it's only a single possible return; this is kinda stupid
      name = result.fetch("name")
      stylist_id = result.fetch("id")
      selection.push(Stylist.new({ :name => name, :id => stylist_id}))
    end
    selection[0]
  end


  define_method(:==) do |another_list|
    self.name().==(another_list.name()).&(self.id().==(another_list.id()))
  end
end
