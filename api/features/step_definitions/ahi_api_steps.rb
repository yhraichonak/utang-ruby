Before do
    @Ahi_api = Ahi_api.new
end

When(/^I execute AHI status API call$/) do
    @response = @Ahi_api.status
end

Then(/^I should receive a fifthEye success response with version number$/) do
    expect(@response['model']['fifthEyeSuccessfulResponse']).to eql true
    expect(@response['model']['version']).not_to be_empty
    puts @response
end

When(/^I execute AHI PostPatientList API call$/) do
    puts @Ahi_api.post_patient_list("super-all", "a", ["a", "b", "c"])
end