# frozen_string_literal: true

When(/^I go to utangserverdb$/) do
  @db_name = nil
  if ENVIRONMENT == '34'
    @db_username = 'sa'
    @db_password = 'A1rstr1p!'
    @db_name = 'utangServer'
    @db_host = '10.10.160.133'
  elsif ENVIRONMENT == '35'
    @db_username = 'sa'
    @db_password = 'A1rstr1p!'
    @db_name = 'utangServer35'
    @db_host = '10.10.160.133'
  elsif ENVIRONMENT == 'automation'
    @db_username = 'utangServerUser'
    @db_password = 'utang'
    @db_name = get_param("COMMON_SERVER_DB_SCHEMA")
    @db_host = get_param("COMMON_SERVER_DB_ADDRESS")
  end

  @client = TinyTds::Client.new username: @db_username, password: @db_password,
                                host: @db_host, port: 1433,
                                database: @db_name
end

When(/^I execute following query from description$/) do
  results = @client.execute("SELECT TOP (1) [Id]
    ,[SnippetType]
    ,[Asmpid]
    ,[SiteId]
    ,[FirstName]
    ,[LastName]
    ,[Mrn]
    ,[Unit]
    ,[EncounterId]
    ,[Data]
    ,[InsertTimestamp_UTC]
    ,[Username]
    ,[EventDescriptions]
    ,[SnippetBeginDateTime_UTC]
    ,[SnippetEndDateTime_UTC]
    ,[Status]
    ,[ReviewedBy]
    ,[Location]
    ,[EnterpriseMrn]
    ,[FacilityCode]
        FROM [#{@db_name}].[dbo].[SnippetDocument]
        order by [InsertTimestamp_UTC] desc")

  results.each do |row|
    @dbSnippetType = row['SnippetType']
    puts @dbSnippetType
  end
end

Then(/^I should see the record of the snippetdocument saved with SnippetType equal to (\d+)$/) do |snippet_doc_type|
  expect(@dbSnippetType.to_i).to eql snippet_doc_type.to_i
end

Then(/^I cleanup baseline worklist snippet in db for mrn "([^"]*)"$/) do |_mrn|
  steps %(
	    When I go to utangserverdb
	)
  results = @client.execute("update [#{@db_name}].[dbo].[SnippetDocument]
                            Set SnippetType = 3
                            where Mrn = '#{_mrn}'
                            and SnippetType = 1;")
  results.each do |row|
    puts row['SnippetType']
  end
end

Then(/^I cleanup the OperationLog table where operation type is "(.*?)"$/) do | operation_type |

  username = USERNAME

  steps %(
	    When I go to utangserverdb
	)
  results = @client.execute("DELETE FROM [#{@db_name}].[dbo].[OperationLog] WHERE [UserName] = '#{username}' AND [OperationType] = '#{operation_type}';")
  results.each do |row|
    puts row['SnippetType']
  end
end

Then(/^I cleanup the OperationLog table where operation type is "(.*?)" for username "(.*?)"$/) do | operation_type, user_name|
  steps %(
	    When I go to utangserverdb
	)
  results = @client.execute("DELETE FROM [#{@db_name}].[dbo].[OperationLog] WHERE [UserName] = '#{user_name}' AND [OperationType] = '#{operation_type}';")
  results.each do |row|
    puts row['SnippetType']
  end
end

And(/^I query the OperationLog table and validate operation type is "(.*?)" for username "(.*?)"$/) do | operation_type, user_name|
  steps %(
	    When I go to utangserverdb
	)
  sql = "SELECT * FROM [#{@db_name}].[dbo].[OperationLog] WHERE [UserName] = '#{user_name}' AND [OperationType] = '#{operation_type}' ORDER BY Timestamp_UTC desc;"

  $ops_log_op_type_results = @client.execute(sql)
  $ops_log_op_type_results.each do |row|
    $u_name = row['UserName']
    $opt_type = row['OperationType']
    $e_content = row['ExtraContext']
  end
  expect($opt_type).to eql operation_type
  expect($u_name).to eql user_name
end


And(/^I query the OperationLog table and validate operation type is "(.*?)" for current user$/) do | operation_type|
  steps %(
	   Then I query the OperationLog table and validate operation type is "#{operation_type}" for username "#{USERNAME}"
	)
end

Then(/^the ExtraContext should contain "(.*?)" evebt description$/) do | operation_type|
  extra_content= JSON.parse($e_content)
  expect(extra_content['eventDescriptions']).to eql operation_type
end

Then(/^the ExtraContext should contain measurementValues for PR QRS QT QTc matching the Snippet Tool screen$/) do
  extra_content= JSON.parse($e_content)
  expect(extra_content['measurementValues']['pr']).to eql @org_pr_value
  expect(extra_content['measurementValues']['qrs']).to eql @org_qrs_value
  expect(extra_content['measurementValues']['qt']).to eql @org_qt_value
  expect(extra_content['measurementValues']['qtc']).to eql @org_qtc_value.strip
end

Then(/^I should see following columns with information: Id, SessionId, ModuleId, UserName, OperationType, SiteId, ExtraContext, Timestamp_UTC$/) do
  id = nil
  session_id = nil
  module_id  = nil
  u_name = nil
  opt_type = nil
  site_id = nil
  e_content = nil
  time_stamp = nil
  insert_time_stamp = nil

  $ops_log_op_type_results.each do |row|
    id = row['Id']
    session_id = row['SessionId']
    module_id = row['ModuleId']
    u_name = row['UserName']
    opt_type = row['OperationType']
    site_id = row['SiteId']
    e_content = row['ExtraContext']
    time_stamp = row['Timestamp_UTC']
    insert_time_stamp = row['InsertTimestamp_UTC']
  end

  expect(id).to be_truthy
  expect(session_id).to be_truthy
  expect(module_id).to be_truthy
  expect(u_name).to be_truthy
  expect(opt_type).to be_truthy
  expect(site_id).to be_truthy
  expect(e_content).to be_truthy
  expect(time_stamp).to be_truthy
  expect(insert_time_stamp).to be_falsey
end

Then(/^I should see following for extraContent column: asmpid, snippetCreationTimestamp$/) do
  extra_content= JSON.parse($e_content)
  expect(extra_content['asmpid']).to be_truthy
  expect(extra_content['snippetCreationTimestamp']).to be_truthy
end

Then(/^I should see following for extraContent column: ReviewedBy, ReviewedAt, CreatedBy, CreatedAt, Asmpid, DocumentId$/) do
  extra_content = JSON.parse($e_content)
  expect(extra_content['ReviewedBy']).to be_truthy
  expect(extra_content['ReviewedAt']).to be_truthy
  expect(extra_content['CreatedBy']).to be_truthy
  expect(extra_content['CreatedAt']).to be_truthy
  expect(extra_content['Asmpid']).to be_truthy
  expect(extra_content['DocumentId']).to be_truthy
end
