require('line')
require('pry')

class Station
attr_reader(:id, :name)

  define_method(:initialize) do |attribute|
    @id = attribute.fetch(:id)
    @name = attribute.fetch(:name)
  end

  define_singleton_method(:all) do
    returned_stations = DB.exec("SELECT * FROM stations;")
    stations = []
    returned_stations.each() do |station|
      name = station.fetch("name")
      id = station.fetch("id").to_i()
      stations.push(Station.new({:name => name, :id => id}))
    end
    stations
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_station|
    self.name().==(another_station.name()).&(self.id().==(another_station.id()))
  end

  define_singleton_method(:find) do |id_number|
    find_result = DB.exec("SELECT * FROM stations WHERE id = #{id_number};")
    name = find_result.first().fetch("name")
    id = find_result.first().fetch("id").to_i()
    Station.new({ :name => name, :id => id})
  end



end
