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

  define_singleton_method(:find) do |id_number|
    find_result = DB.exec("SELECT * FROM lines WHERE id = #{id_number};")
    name = find_result.first().fetch("name")
    id = find_result.first().fetch("id").to_i()
    Line.new({ :name => name, :id => id})
  end
  #
  # define_method(:stations)


end
