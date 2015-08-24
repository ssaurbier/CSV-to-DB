#YOUR CODE GOES HERE

require 'csv'
require "pg"

def db_connection
  begin
    connection = PG.connect(dbname: "ingredients")
    yield(connection)
  ensure
    connection.close
  end
end

CSV.foreach('ingredients.csv') do |row|
  db_connection do |conn|
    # inserts object into file
    #{}"INSERT INTO ingredients (name) VALUES (#{row[1]})"
    #above is sql command
      conn.exec_params("INSERT INTO ingredients (name) VALUES ($1)", [row[1]])
    end
  end


db_connection do |conn|
  results = conn.exec('SELECT name FROM ingredients;')
  results.each do |output|
    puts "#{output['name']}"
  end
end
