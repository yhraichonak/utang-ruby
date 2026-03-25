Before do
    @DB_Client = DB_Client.new
  end
  
  Then(/^it should return the most recent frat id from database$/) do
    #74d44abc-0884-4ff5-a2c8-a67951c67bee
    sql = "SELECT [Id], [Asmpid], [SiteId] FROM [acwaservices].[dbo].[FratRecords] \
    WHERE [CreatedTimestamp] = (SELECT MAX([CreatedTimestamp]) \
    FROM [acwaservices].[dbo].[FratRecords] where [Asmpid] = '#{$patient_mpid}')"

    response = @DB_Client.execute_sql(sql)
    expect(response[0]['Asmpid']).to eq $patient_mpid
    expect(response[0]['SiteId']).to eq '4429'
     
    $latest_frat_id = response[0]['Id']
    puts "patient mpid: #{$patient_mpid} - latest frat id: #{$latest_frat_id}"
  end

  Then(/^it should return the most recent frat client info from database$/) do
    #74d44abc-0884-4ff5-a2c8-a67951c67bee
    sql = "SELECT [ClientInfo] FROM [acwaservices].[dbo].[FratRecords] \
    WHERE [Id] = '#{$latest_frat_id}'"

    response = @DB_Client.execute_sql(sql)
        
    $latest_frat_client_info = response[0]['ClientInfo']
    puts "latest frat id: #{$latest_frat_id} - latest client info #{$latest_frat_client_info}"
    c_info = JSON.parse($latest_frat_client_info)
    expect(c_info['Name']).to eq 'utang-one-web'
  end

  Then(/^it should return the most recent frat file string from database$/) do
    #74d44abc-0884-4ff5-a2c8-a67951c67bee
    sql = "SELECT [File] FROM [acwaservices].[dbo].[FratRecords] \
    WHERE [Id] = '#{$latest_frat_id}'"

    response = @DB_Client.execute_sql(sql)
        
    $latest_frat_file_string = response[0]['File']
    puts "latest frat id: #{$latest_frat_id} - latest client info #{$latest_frat_file_string}"
    f_info = JSON.parse($latest_frat_file_string)
    expect(f_info['Id']).to eq $latest_frat_id
  end