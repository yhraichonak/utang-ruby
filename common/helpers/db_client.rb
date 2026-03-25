
require 'tiny_tds'

class DB_Client
  def execute_sql(db_ip, db_port, db_user, db_password, db_name, sql)
    client = TinyTds::Client.new username: db_user, password: db_password, host: db_ip, port: db_port, database: db_name, azure: false
    puts "executing sql: #{sql}"
    result = client.execute(sql).to_a
    client.close
    return result
  end

  def execute_multiple_sqls(db_ip, db_port, db_user, db_password, db_name, sqls)
    client = TinyTds::Client.new username: db_user, password: db_password, host: db_ip, port: db_port, database: db_name, azure: false
    result=nil
    client.execute("SET ANSI_NULLS ON")
    client.execute("SET QUOTED_IDENTIFIER ON")
    client.execute("SET CONCAT_NULL_YIELDS_NULL ON")
    client.execute("SET ANSI_WARNINGS ON")
    client.execute("SET ANSI_PADDING ON")
    sqls.each{|sql|
    puts "executing sql: #{sql}"
    result = client.execute(sql).do
    }
    client.close
    result
  end
end
