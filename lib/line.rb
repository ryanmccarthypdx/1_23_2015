require('station')
require('pry')

class Line
attr_reader(:id, :name)

  define_method(:initialize) do |attribute|
    @id = attribute.fetch(:id)
    @name = attribute.fetch(:name)
  end

  define_singleton_method(:all) do
    returned_lines = DB.exec("SELECT * FROM lines;")
    lines = []
    returned_lines.each() do |line|
      name = line.fetch("name")
      id = line.fetch("id").to_i()
      lines.push(Line.new({:name => name, :id => id}))
    end
    lines
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_line|
    self.name().==(another_line.name()).&(self.id().==(another_line.id()))
  end

  define_singleton_method(:find_by_id) do |id_input|
    find_result = DB.exec("SELECT * FROM lines WHERE id = #{id_input};")
    name = find_result.first().fetch("name")
    id = find_result.first().fetch("id").to_i()
    Line.new({ :name => name, :id => id})
  end

  define_singleton_method(:find_by_name) do |name_input|
    find_result = DB.exec("SELECT * FROM lines WHERE name = '#{name_input}';")
    name = find_result.first().fetch("name")
    id = find_result.first().fetch("id").to_i()
    Line.new({ :name => name, :id => id})
  end

  define_method(:associate) do |stations_to_associate|
    @line_id = self.id()
    stations_to_associate.each() do |station|
      @station_id = Station.find_by_name(station).id()
      DB.exec("INSERT INTO stops (line_id, station_id) VALUES ('#{@line_id}', '#{@station_id}');")
    end
  end

  define_method(:stations) do
    station_ids = []
    stations_objects_output = []
    @line_id = self.id()
    station_id_search_result = DB.exec("SELECT * FROM stops WHERE line_id = #{@line_id};")
    station_id_search_result.each() do |station|
      stop_id = station.fetch('station_id')#############################
      station_ids.push(stop_id)
    end
    station_ids.each() do |station_id_on_line|
      s_i_r = DB.exec("SELECT * FROM stations WHERE id = '#{station_id_on_line}';")##################
      name = s_i_r.first().fetch("name")
      stations_objects_output.push(Station.new({ :name => name, :id => (station_id_on_line.to_i) }))
    end
    stations_objects_output
  end

    #loop to look in STOPS and return the station_ids associated with the line in question
    #loop through and return the station names associated with the station_ids from the STOPS list
    #recreate station objects with the names and ids from above
    #push those station objects into the output array
    #return the output array








  #define_method(:stations) do


end
