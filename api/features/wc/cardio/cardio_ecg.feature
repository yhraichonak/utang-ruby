@cardio_ecg
Feature: Cardio ECG Endpoint

  Scenario: User is able to get Cardio ECG
    Then User is able to login into the system with valid credentials
    When user executes cardio/ecg GET request with query params "asmpid=[props.DP_ASMPID]&ecgid=[props.DP_ECGID]"
    Then system should return data
    """
{
"..model..ecgId":"[props.DP_ECGID]",
"..model..shouldShowEditConfirm":"false",
"..model..shouldShowMMIV":"false",
"..model..limitedDataCarePointECG":"false",
"..model..acknowledged":"false",
"..model..acknowledgementRequired":"false",
"..model..ecgDetails..diagnosis":"Normal sinus rhythm",
"..model..ecgDetails..analysis":"Normal sinus rhythm",
"..model..ecgDetails..acquisitionDateTime":"matches:(\\d\\d\\d\\d-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\d-\\d\\d:\\d\\d)",
"..model..ecgDetails..sex":"MALE",
"..model..ecgDetails..dob":"07/31/1952",
"..model..ecgDetails..age":"70 YEARS",
"..model..ecgDetails..pr":"120",
"..model..ecgDetails..vhr":"142",
"..model..ecgDetails..ahr":"144",
"..model..ecgDetails..qrs":"64",
"..model..ecgDetails..qt":"350",
"..model..ecgDetails..prt":"71 79 75",
"..model..leads..title[0]":"I","..model..leads..values[0]":"matches:(\[.*\])",
"..model..leads..title[1]":"II","..model..leads..values[1]":"matches:(\[.*\])",
"..model..leads..title[2]":"III","..model..leads..values[2]":"matches:(\[.*\])",
"..model..leads..title[3]":"aVR","..model..leads..values[3]":"matches:(\[.*\])",
"..model..leads..title[4]":"aVL","..model..leads..values[4]":"matches:(\[.*\])",
"..model..leads..title[5]":"aVF","..model..leads..values[5]":"matches:(\[.*\])",
"..model..leads..title[6]":"V1","..model..leads..values[6]":"matches:(\[.*\])",
"..model..leads..title[7]":"V2","..model..leads..values[7]":"matches:(\[.*\])",
"..model..leads..title[8]":"V3","..model..leads..values[8]":"matches:(\[.*\])",
"..model..leads..title[9]":"V4","..model..leads..values[9]":"matches:(\[.*\])",
"..model..leads..title[10]":"V5","..model..leads..values[10]":"matches:(\[.*\])",
"..model..leads..title[11]":"V6","..model..leads..values[11]":"matches:(\[.*\])",
"..model..leads..title[12]":"V3R","..model..leads..values[12]":"matches:(\[.*\])",
"..model..leads..title[13]":"V4R","..model..leads..values[13]":"matches:(\[.*\])",
"..model..leads..title[14]":"V7","..model..leads..values[14]":"matches:(\[.*\])"
}
"""


  Scenario: User is able to get Cardio ECG - Request Edit
    Then User is able to login into the system with valid credentials
    When user executes cardio/requestedit GET request with query params "ecgid=[props.DP_ECGID]"
    Then system should return data
    """
{
"..model..allowEdit":"false",
"..model..userMessage":"Please Confirm Test By Other Means",
"..model..ecgTimestamp":"0"
}
"""

  Scenario: User is able to get Cardio ECG list
    Then User is able to login into the system with valid credentials
    When user executes cardio/ecglist GET request with query params "asmpid=[props.DP_ASMPID]"
    Then system should return data
    """
{
"..model..ecgId[0]":"matches:(\\d+)", "..model..diagnosis[0]":"matches:(.*)","..model..analysis[0]":"matches:(.*)",
"..model..date[0]":"matches:(\\d\\d\\d\\d-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\d-\\d\\d:\\d\\d)",
"..model..confirmed[0]":"false", "..model..acknowledged[1]":"false", "..model..acknowledgementRequired[0]":"false",
"..model..ecgId[1]":"matches:(\\d+)", "..model..diagnosis[1]":"matches:(.*)","..model..analysis[1]":"matches:(.*)",
"..model..date[1]":"matches:(\\d\\d\\d\\d-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\d-\\d\\d:\\d\\d)",
"..model..confirmed[1]":"false", "..model..acknowledged[1]":"false", "..model..acknowledgementRequired[1]":"false"
}
"""

  Scenario: User is able to get Cardio ECG compare
    Then User is able to login into the system with valid credentials
    When user executes cardio/ecg GET request with query params "asmpid=[props.DP_ASMPID]&ecgid=[props.DP_ECGID]&ecg2id=[props.DP_ECG2ID]"
    Then system should return data
    """
{
"..model..ecgId[0]":"[props.DP_ECGID]",
"..model..shouldShowEditConfirm[0]":"false",
"..model..shouldShowMMIV[0]":"false",
"..model..limitedDataCarePointECG[0]":"false",
"..model..acknowledged[0]":"false",
"..model..acknowledgementRequired[0]":"false",
"..model..ecgDetails[0]":"matches:.*diagnosis.*analysis.*acquisitionDateTime.*sex.*dob.*age.*pr.*vhr.*ahr.*qrs.*qt.*prt.*",
"..model..leads[0]":"matches:.*title.*values.*",
"..model..ecgId[1]":"[props.DP_ECG2ID]",
"..model..shouldShowEditConfirm[1]":"false",
"..model..shouldShowMMIV[1]":"false",
"..model..limitedDataCarePointECG[1]":"false",
"..model..acknowledged[1]":"false",
"..model..acknowledgementRequired[1]":"false",
"..model..ecgDetails[1]":"matches:.*diagnosis.*analysis.*acquisitionDateTime.*sex.*dob.*age.*pr.*vhr.*ahr.*qrs.*qt.*prt.*",
"..model..leads[1]":"matches:.*title.*values.*"
}
"""