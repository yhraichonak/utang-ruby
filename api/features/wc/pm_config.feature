@pm_config
Feature: PM Configuration Endpoint

  Scenario: User is able to get PM Config
    Then User is able to login into the system with valid credentials
     When user executes pm/config GET request with query params "asmpid=[props.DP_ASMPID]"
   Then system should return data
    """
{
"..model..waveGroups..title[0]":"ECG-II","..model..waveGroups..lineColor[0]":"2EAE2A",
"..model..waveGroups..title[1]":"matches:(ECG-V1|ECG-I|ECG-AVF|ECG-AVL|ECG-AVR|ECG-III|ECG-V2)","..model..waveGroups..lineColor[1]":"2EAE2A",
"..model..waveGroups..title[2]":"matches:(ECG-V1|ECG-I|ECG-AVF|ECG-AVL|ECG-AVR|ECG-III|ECG-V2)","..model..waveGroups..lineColor[2]":"2EAE2A",
"..model..waveGroups..title[3]":"matches:(ECG-V1|ECG-I|ECG-AVF|ECG-AVL|ECG-AVR|ECG-III|ECG-V2)","..model..waveGroups..lineColor[3]":"2EAE2A",
"..model..waveGroups..title[4]":"matches:(ECG-V1|ECG-I|ECG-AVF|ECG-AVL|ECG-AVR|ECG-III|ECG-V2)","..model..waveGroups..lineColor[4]":"2EAE2A",
"..model..waveGroups..title[5]":"matches:(ECG-V1|ECG-I|ECG-AVF|ECG-AVL|ECG-AVR|ECG-III|ECG-V2)","..model..waveGroups..lineColor[5]":"2EAE2A",
"..model..waveGroups..title[6]":"matches:(ECG-V1|ECG-I|ECG-AVF|ECG-AVL|ECG-AVR|ECG-III|ECG-V2)","..model..waveGroups..lineColor[6]":"2EAE2A",
"..model..discreteGroups..title[0]":"HR bpm","..model..discreteGroups..textColor[0]":"2EAE2A",
"..model..discreteGroups..title[1]":"RR bpm","..model..discreteGroups..textColor[1]":"4875B1",
"..model..discreteGroups..title[2]":"ST mm","..model..discreteGroups..textColor[2]":"2EAE2A",
"..model..discreteGroups..title[3]":"PVC Bpm","..model..discreteGroups..textColor[3]":"2EAE2A"

}
"""
