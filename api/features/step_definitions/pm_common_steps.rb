require 'async'
Before do
  @Common_api = Common_api.new
  @Fed_api = Fed_api.new
end

Given(/^PM alarm was generated for patient with session "(.*)" with alarm text "(.*)" and "(NoShow|Low|Medium|High|NoShowNonOem|LowNonOem|MediumNonOem|HighNonOem)" severity for (.*) seconds$/) do | session, alm_text, alm_severity, duraiton |
    session=process_param(session)
    session=session.gsub("'","")
    @Common_api.generate_patient_alarm(session, alm_text, alm_severity, duraiton)
end
Given(/^PM alarm was generated for patient "(.*)" with alarm text "(.*)" and "(NoShow|Low|Medium|High|NoShowNonOem|LowNonOem|MediumNonOem|HighNonOem)" severity for (.*) seconds$/) do | patient_full_name, alm_text, alm_severity, duraiton |
  patient_full_name = process_param(patient_full_name)
  names = patient_full_name.split(",")
  begin
    steps %(
    When I login to the api with a valid credential
  )
    @response = @Fed_api.do_execute_get_with_query_params("patientlist", process_param("listtype=search&searchkey1=#{names[1].strip!}&searchkey2=#{names[0].strip!}"), "1")
    mrn = @response['model']['patients'][0]['mrn']
  rescue => e
    log_eror("Error on attempt to find MRN by patient name #{patient_full_name}")
  end
  @Common_api.generate_patient_alarm(@Common_api.get_session_by_mrn(mrn), alm_text, alm_severity, duraiton)
end

Given(/^PM async alarm was generated for patient "(.*)" with alarm text "(.*)" and "(NoShow|Low|Medium|High|NoShowNonOem|LowNonOem|MediumNonOem|HighNonOem)" severity for (.*) seconds$/) do | patient_full_name, alm_text, alm_severity, duraiton |
  patient_full_name = process_param(patient_full_name)
  names = patient_full_name.split(",")
  begin
    steps %(
    When I login to the api with a valid credential
  )
    @response = @Fed_api.do_execute_get_with_query_params("patientlist", process_param("listtype=search&searchkey1=#{names[1].strip!}&searchkey2=#{names[0].strip!}"), "1")
    mrn = @response['model']['patients'][0]['mrn']
    sessionid=@Common_api.get_session_by_mrn(mrn)
  rescue => e
    log_eror("Error on attempt to find SessionID by patient name #{patient_full_name}")
  end
  api_file_path=File.expand_path(File.dirname(__FILE__)+"/../lib/apis/common_api.rb")
  target_script="ruby -r \"#{api_file_path}\" -e \"Common_api.generate_patient_alarm_async('#{$COMMON_API_URL}','#{sessionid}', '#{alm_text}', '#{alm_severity}', '#{duraiton}')\""
  $ALARM_PID=Process.spawn(target_script)
end
