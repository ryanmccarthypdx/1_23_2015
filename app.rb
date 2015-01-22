require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/line')
require('./lib/station')
require('pg')

DB = PG.connect({:dbname => "train"})

get('/') do
  @title = "JaqRy Railways"
  @list_of_lines = Line.all()
  @list_of_stations = Station.all()
  erb(:main)
end

post('/post_line') do
  @line_name = params.fetch("line_name")
  new_line = Line.new({ :name => @line_name, :id => nil })
  new_line.save()
  @title = "JaqRy Railways"
  @list_of_lines = Line.all()
  @list_of_stations = Station.all()
  erb(:main)
end

post('/patch_line') do
  @line_name = params.fetch("line_name")
  @station_string = params.fetch("station_names_string")
  @line_obj = Line.find_by_name(@line_name)
  @line_obj.associate(@station_string)
  @title = "JaqRy Railways"
  @list_of_lines = Line.all()
  @list_of_stations = Station.all()
  erb(:main)
end

post('/post_station') do
  @station_name = params.fetch("station_name")
  new_station = Station.new({ :name => @station_name, :id => nil })
  new_station.save()
  @title = "JaqRy Railways"
  @list_of_lines = Line.all()
  @list_of_stations = Station.all()
  erb(:main)
end

post('/patch_station') do
  @station_name = params.fetch("station_name")
  @line_string = params.fetch("line_names_string")
  @station_obj = Station.find_by_name(@station_name)
  @station_obj.associate(@line_string)
  @title = "JaqRy Railways"
  @list_of_lines = Line.all()
  @list_of_stations = Station.all()
  erb(:main)
end

get('/lines/:id') do
  @id = params.fetch('id')
  @line = Line.find_by_id(@id)
  @name = @line.name()
  @title = @name.concat(" line")
  @stations_list = @line.stations()
  erb(:line)
end

get('/stations/:id') do
  @id = params.fetch('id')
  @station = Station.find_by_id(@id)
  @name = @station.name()
  @title = @name.concat(" station")
  @lines_list = @station.lines()
  erb(:station)
end
