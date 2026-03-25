Before do
    @AlertManager_api = AlertManager_api.new
end

Then(/^it should return the ACWA status$/) do | table |
    response = @Acwa_api.get_status

    values = table.hashes
    expect(response["machineName"]).to eq values[0]["machineName"]   
end

Then(/^it should return the ACWA version$/) do | table |
    response = @Acwa_api.get_version

    values = table.hashes

    expect(response["applicationVersion"]).to eq values[0]["applicationVersion"]  
    expect(response["domainVersion"]).to eq values[0]["domainVersion"]  
    expect(response["algorithms"][0]["name"]).to eq values[0]["name"]  
    expect(response["algorithms"][0]["version"]).to eq values[0]["version"]  
    expect(response["algorithms"][0]["date"]).to eq values[0]["date"]  
    expect(response["algorithms"][0]["info"]).to eq values[0]["info"]  
end

Then(/^it should return all alerts$/) do 
    response = @AlertManager_api.get_alerts
    puts response
    $alerts_count = response.count
    puts "the alerts count = #{$alerts_count}"
    #expect(response["responseCode"]).to eq 0
    #expect(response["model"].count).to be >= 0
    
    for i in 0..($alerts_count - 1)
        puts "===== alert #{i + 1 } ====="
        puts "alert id = #{response[i]["id"]}"
        puts "alert status = #{response[i]["status"]}"
        puts "alert type = #{response[i]["type"]}"
        puts "alert message = #{response[i]["message"]}"
        puts "alert acceptedBy = #{response[i]["acceptedBy"]}"
        puts "alert acknowledgementRequired = #{response[i]["acknowledgementRequired"]}"
        puts "alert createdAt = #{response[i]["createdAt"]}"
        puts "alert acceptedAt = #{response[i]["acceptedAt"]}"
        
        notifications_count = response[i]["notifications"].count
        puts "notifcation count = #{notifications_count}"

        for z in 0..(notifications_count - 1)
            puts "+++++ notification #{z + 1} +++++"
            puts  "notification id = #{response[i]["notifications"][z]["id"]}"
            puts  "notification username = #{response[i]["notifications"][z]["username"]}"
            puts  "notification sentAtUtc = #{response[i]["notifications"][z]["sentAtUtc"]}"
            puts  "notification responseAt = #{response[i]["notifications"][z]["responseAt"]}"
            puts  "notification responseBy = #{response[i]["notifications"][z]["responseBy"]}"
            puts  "notification status = #{response[i]["notifications"][z]["status"]}"
            puts  "notification notes = #{response[i]["notifications"][z]["notes"]}"
            puts "+++++ end notification #{z + 1} +++++"
        end
        puts "===== end alert #{i + 1} ====="
    end


    case 
    when $alerts_count >= 16
        $id_one = response[0]["id"]
        $id_two = response[1]["id"]
        $id_three = response[2]["id"]
        $id_four = response[3]["id"]
        $id_five = response[4]["id"]
        $id_six = response[5]["id"]
        $id_seven = response[6]["id"]
        $id_eight = response[7]["id"]
        $id_nine = response[8]["id"]
        $id_ten = response[9]["id"]
        $id_eleven = response[10]["id"]
        $id_twelve = response[11]["id"]
        $id_thirteen = response[12]["id"]
        $id_fourteen = response[13]["id"]
        $id_fifteen = response[14]["id"]
        $id_sixteen = response[15]["id"]
    when $alerts_count = 15
        $id_one = response[0]["id"]
        $id_two = response[1]["id"]
        $id_three = response[2]["id"]
        $id_four = response[3]["id"]
        $id_five = response[4]["id"]
        $id_six = response[5]["id"]
        $id_seven = response[6]["id"]
        $id_eight = response[7]["id"]
        $id_nine = response[8]["id"]
        $id_ten = response[9]["id"]
        $id_eleven = response[10]["id"]
        $id_twelve = response[11]["id"]
        $id_thirteen = response[12]["id"]
        $id_fourteen = response[13]["id"]
        $id_fifteen = response[14]["id"]
    else
        "alert count not found"
    end


    puts $id_one
    puts $id_two

end