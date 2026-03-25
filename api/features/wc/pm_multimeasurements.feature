@pm_multimeasurements
Feature: PM Multimeasurements Endpoint

  Scenario: User is able to get multimeasurements with single asmpid
    Then User is able to login into the system with valid credentials
    When user executes pm/multimeasurements GET request with query params "asmpid=[props.DP_ASMPID]&bookmark=11"
    Then system should return data
    """
{
"..model..[props.DP_ASMPID]..isActive":"true",
"..model..[props.DP_ASMPID]..bookmark":"matches:(\\d+)",
"..model..[props.DP_ASMPID]..data..timestamp":"matches:(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z)",
"..model..[props.DP_ASMPID]..data..waveData..key":"matches:(\\d+)",
"..model..[props.DP_ASMPID]..data..waveData..min":"matches:([\\d-]+)",
"..model..[props.DP_ASMPID]..data..waveData..max":"matches:(\\d+)",
"..model..[props.DP_ASMPID]..data..waveData..data":"matches:(\\[.*\\])",
"..model..[props.DP_ASMPID]..serverTimestamp":"matches:(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z)"
}
"""

  Scenario: User is able to get multimeasurements with multiple asmpid's
    Then User is able to login into the system with valid credentials
    When user executes pm/multimeasurements GET request with query params "asmpid=[props.DP_ASMPID],[props.DP2_ASMPID]&bookmark=11,11"
    Then system should return data
    """
{
"..model..[props.DP_ASMPID]..isActive":"true",
"..model..[props.DP_ASMPID]..bookmark":"matches:(\\d+)",
"..model..[props.DP_ASMPID]..data..timestamp":"matches:(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z)",
"..model..[props.DP_ASMPID]..data..waveData..key":"matches:(\\d+)",
"..model..[props.DP_ASMPID]..data..waveData..min":"matches:([\\d-]+)",
"..model..[props.DP_ASMPID]..data..waveData..max":"matches:(\\d+)",
"..model..[props.DP_ASMPID]..data..waveData..data":"matches:(\\[.*\\])",
"..model..[props.DP_ASMPID]..serverTimestamp":"matches:(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z)",
"..model..[props.DP2_ASMPID]..isActive":"true",
"..model..[props.DP2_ASMPID]..bookmark":"matches:(\\d+)",
"..model..[props.DP2_ASMPID]..data..timestamp":"matches:(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z)",
"..model..[props.DP2_ASMPID]..data..waveData..key":"matches:(\\d+)",
"..model..[props.DP2_ASMPID]..data..waveData..min":"matches:([\\d-]+)",
"..model..[props.DP2_ASMPID]..data..waveData..max":"matches:(\\d+)",
"..model..[props.DP2_ASMPID]..data..waveData..data":"matches:(\\[.*\\])",
"..model..[props.DP2_ASMPID]..serverTimestamp":"matches:(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z)"
}
"""

  Scenario: User is not able to get multimeasurements from invalid asmpid
    Then User is able to login into the system with valid credentials
    When user executes pm/multimeasurements GET request with query params "asmpid=[props.DP_ASMPID],[props.COMMON_FALSE_ASMPID]&bookmark=11,11"
    Then system should return data
    """
{
"..model..[props.DP_ASMPID]..isActive":"true",
"..model..[props.DP_ASMPID]..bookmark":"matches:(\\d+)",
"..model..[props.DP_ASMPID]..data..timestamp":"matches:(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z)",
"..model..[props.DP_ASMPID]..data..waveData..key":"matches:(\\d+)",
"..model..[props.DP_ASMPID]..data..waveData..min":"matches:([\\d-]+)",
"..model..[props.DP_ASMPID]..data..waveData..max":"matches:(\\d+)",
"..model..[props.DP_ASMPID]..data..waveData..data":"matches:(\\[.*\\])",
"..model..[props.DP_ASMPID]..serverTimestamp":"matches:(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z)",
"..model..[props.COMMON_FALSE_ASMPID]..isActive":"false",
"..model..[props.COMMON_FALSE_ASMPID]..bookmark":"",
"..model..[props.COMMON_FALSE_ASMPID]..data":[],
"..model..[props.COMMON_FALSE_ASMPID]..serverTimestamp":"matches:(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z)"
}
"""