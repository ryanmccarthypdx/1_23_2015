require('./lib/line')
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

  define_singleton_method(:find_by_id) do |id_input|
    find_result = DB.exec("SELECT * FROM stations WHERE id = #{id_input};")
    name = find_result.first().fetch("name")
    id = find_result.first().fetch("id").to_i()
    Station.new({ :name => name, :id => id})
  end

  define_singleton_method(:find_by_name) do |name_input|
    find_result = DB.exec("SELECT * FROM stations WHERE name = '#{name_input}';")
    name = find_result.first().fetch("name")
    id = find_result.first().fetch("id").to_i()
    Station.new({ :name => name, :id => id})
  end

  define_method(:associate) do |lines_to_associate_string|
    lines_to_associate = lines_to_associate_string.split(", ")
    @station_id = self.id()
    lines_to_associate.each() do |line|
      @line_id = Line.find_by_name(line).id()
      DB.exec("INSERT INTO stops (line_id, station_id) VALUES ('#{@line_id}', '#{@station_id}');")
    end
  end

  define_method(:lines) do
    line_ids = []
    lines_objects_output = []
    @station_id = self.id()
    line_id_search_result = DB.exec("SELECT * FROM stops WHERE station_id = '#{@station_id}';")
    line_id_search_result.each() do |line|
      stop_id = line.fetch('line_id')
      line_ids.push(stop_id)
    end
    line_ids.each() do |line_id_at_station|
      l_i_r = DB.exec("SELECT * FROM lines WHERE id = '#{line_id_at_station}';")
      name = l_i_r.first().fetch("name")
      lines_objects_output.push(Line.new({ :name => name, :id => (line_id_at_station.to_i) }))
    end
    lines_objects_output
  end


end
