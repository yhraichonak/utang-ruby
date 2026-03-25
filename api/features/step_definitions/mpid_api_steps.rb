Before do
  @Mpid_api = Mpid_api.new
end

Then(/^it should return sync payload "(.*?)"$/) do | payload |
  response = @Mpid_api.sync(payload)
 
  puts "####{response}##"
  $ASMPID_1 = response["KEY1"]["Value"]
end

Then(/^it should sync Patient MPID "(.*?)"$/) do | data |  
  response = @Mpid_api.sync(data)
  response.to_s.gsub(/\s+/, "").should match '{"KEY1"=>{"Value"=>"(.*)"}}'
  
  $ASMPID_1 = response["KEY1"]["Value"]
  
  if $DEBUG_FLAG == "debug"
    puts $ASMPID_1
  end
  
  data = JSON.parse data.gsub('=>', ':')
    
  mod = data["KEY1"]["module"]
  mrn = data["KEY1"]["mrn"]
  first_name = data["KEY1"]["firstName"]
  last_name = data["KEY1"]["lastName"]
  mrncontext = data["KEY1"]["mrncontext"]
  associable = data["KEY1"]["associable"]
  
  if $DEBUG_FLAG == "debug"
    puts "mod = #{mod}"
    puts "mrn = #{mrn}"
    puts "first_name = #{first_name}"
    puts "last_name = #{last_name}"
    puts "mrncontext = #{mrncontext}"
    puts "associable = #{associable}"
  end
  
  new_response = @Mpid_api.sync_with_mpid($ASMPID_1)
  
  if $DEBUG_FLAG == "debug"
    puts "new response = #{new_response}"
  end
      
  if(new_response["#{$ASMPID_1}"].nil?)
  
  else
    if $DEBUG_FLAG == "debug"
      puts "moduel = #{new_response["#{$ASMPID_1}"]["Module"]}"
      puts "mrn = #{new_response["#{$ASMPID_1}"]["Mrn"]}"
      puts "first = #{new_response["#{$ASMPID_1}"]["FirstName"]}"
      puts "last = #{new_response["#{$ASMPID_1}"]["LastName"]}"
      puts "mrncontext = #{new_response["#{$ASMPID_1}"]["Mrncontext"]}"
      puts "associable = #{new_response["#{$ASMPID_1}"]["Associable"]}"
    end
    
    expect(mod).to eq new_response["#{$ASMPID_1}"]["Module"]
    expect(mrn).to eq new_response["#{$ASMPID_1}"]["Mrn"]
    expect(first_name).to eq new_response["#{$ASMPID_1}"]["FirstName"]
    expect(last_name).to eq new_response["#{$ASMPID_1}"]["LastName"]
    expect(mrncontext).to eq new_response["#{$ASMPID_1}"]["MrnContext"]
    expect(associable).to eq new_response["#{$ASMPID_1}"]["Associable"]
  end
end
