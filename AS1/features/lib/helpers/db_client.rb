# frozen_string_literal: true

require 'tiny_tds'

class DB_Client
  def execute_sql(sql)
    client = TinyTds::Client.new username: DB_USERNAME, password: DB_PASSWORD, 
    host: DB_SERVER, port: 1433, database: DB_NAME, azure: false

    puts "executing sql: #{sql}"

    result = client.execute(sql)
    return result.to_a
  end
end