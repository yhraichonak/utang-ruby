Before do
  @Status_api = Status_api.new
end

Then(/^it should return the fed-web status for site "(.*?)"$/) do | site_id |
  response = @Status_api.fed_web_status
    
  expect(response["configuration"]["isEnabledCardio"]).to be true
  expect(response["configuration"]["isEnabledEmr"]).to be false
  expect(response["configuration"]["isEnabledPm"]).to be true
  expect(response["configuration"]["isEnabledOutpatient"]).to be false
  if site_id == "34"
    expect(response["configuration"]["isEnabledOb"]).to be false
    expect(response["configuration"]["cardioBaseAddress"]).to eq "http://10.10.160.133:9034"
    expect(response["configuration"]["pmBaseAddress"]).to eq "http://10.10.160.156:8765/"
    expect(response["configuration"]["hostBaseAddress"]).to eq "http://10.10.160.133/34/fed-host/api/"
    expect(response["configuration"]["obBaseAddress"]).to eq "http://localhost/ob/api/"
    expect(response["configuration"]["isEnabledPmProxy"]).to be false
    expect(response["moduleStatuses"]["cardio"]["httpStatusCode"]).to eq 200
    expect(response["moduleStatuses"]["cardio"]["content"]["responseCode"]).to eq 0
    expect(response["configuration"]["emrBaseAddress"]).to eq "http://localhost/emr/api/"
    expect(response["configuration"]["asmpiBaseAddress"]).to eq "http://10.10.160.133/asmpi/api"
  elsif site_id == "35"
    expect(response["configuration"]["isEnabledOb"]).to be true
    expect(response["configuration"]["cardioBaseAddress"]).to eq "http://10.10.160.133:9035"
    expect(response["configuration"]["pmBaseAddress"]).to eq "http://10.10.160.132:8765"
    expect(response["configuration"]["hostBaseAddress"]).to eq "http://10.10.160.133/35/fed-host/api/"
    expect(response["configuration"]["obBaseAddress"]).to eq "http://10.10.160.133/35/ob/api/"
    expect(response["configuration"]["isEnabledPmProxy"]).to be true
    expect(response["moduleStatuses"]["cardio"]["httpStatusCode"]).to eq 200
    expect(response["configuration"]["emrBaseAddress"]).to eq "http://localhost/emr/api/"
    expect(response["configuration"]["asmpiBaseAddress"]).to eq "http://10.10.160.133/asmpi/api"
  elsif site_id == "automation"
    expect(response["configuration"]["isEnabledOb"]).to be false
    expect(response["configuration"]["cardioBaseAddress"]).to eq "http://10.106.5.18:9000"
    expect(response["configuration"]["pmBaseAddress"]).to include "http://10.106.5.18:8765"
    expect(response["configuration"]["hostBaseAddress"]).to eq "http://10.106.5.18/fed-host/api/"
    expect(response["configuration"]["obBaseAddress"]).to eq "http://10.106.5.18/ob/api"
    expect(response["configuration"]["isEnabledPmProxy"]).to be false
    expect(response["moduleStatuses"]["cardio"]["httpStatusCode"]).to eq 200
    expect(response["configuration"]["emrBaseAddress"]).to match "(http://localhost/emr/api/|http://10.106.5.18/emr/api)"
    expect(response["configuration"]["asmpiBaseAddress"]).to include "http://10.106.5.18/asmpi/api"
  end

  expect(response["configuration"]["outpatientBaseAddress"]).to include "https://10.10.0.143/emr-allscripts/api"
  expect(response["configuration"]["isEnabledCardioProxy"]).to be false
  expect(response["configuration"]["pmProxyModuleInstances"][0]).to include "http://10.106.5.18:8765"
  expect(response["moduleStatuses"]["pm"]["httpStatusCode"]).to eq 200
  expect(response["moduleStatuses"]["pm"]["content"]["responseCode"]).to eq 0
  expect(response["moduleStatuses"]["host"]["httpStatusCode"]).to eq 200  
end

Then(/^it should return the fed-host status for site "(.*?)"$/) do | site_id |  
  response = @Status_api.fed_host_status(site_id)
  expect(response["model"]).to eq('Sh4r3d_K3y_F0r_t3st1ing_0nly_32B')
end