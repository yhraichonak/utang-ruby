@pm_measurement
Feature: PM Measurements Endpoint

  Scenario: User is able to get measurements - bookmark
    Then User is able to login into the system with valid credentials
     When user executes pm/measurements GET request with query params "asmpid=[props.DP_ASMPID]&bookmark=1"
   Then system should return data
    """
{
"..model..isActive":"true",
"..model..bookmark":"matches:(\\d+)",
"..model..serverTimestamp":"matches:(\\d\\d\\d\\d-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\dZ)",
"..model..data..timestamp":"matches:(\\d\\d\\d\\d-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\dZ)",
"..model..data..waveData..key":"matches:(\\d+)",
"..model..data..waveData..min":"matches:([\\d-]+)",
"..model..data..waveData..max":"matches:(\\d+)",
"..model..data..waveData..data":"matches:(\\[.*\\])"
}
"""

 Scenario: User is able to get measurements - seconds
  Then User is able to login into the system with valid credentials
  When user executes pm/measurements GET request with query params "asmpid=[props.DP_ASMPID]&seconds=2"
  Then system should return data
    """
{
"..model..isActive":"true",
"..model..bookmark":"matches:(\\d+)",
"..model..serverTimestamp":"matches:(\\d\\d\\d\\d-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\dZ)",
"..model..data..timestamp[0]":"matches:(\\d\\d\\d\\d-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\dZ)",
"..model..data..waveData[0]":"matches:(\\[\\{.*\\}\\])",
"..model..data..timestamp[1]":"matches:(\\d\\d\\d\\d-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\dZ)",
"..model..data..waveData[1]":"matches:(\\[\\{.*\\}\\])"
}
"""

  Scenario: User is able to get measurements - starttime, endtime
    Then User is able to login into the system with valid credentials
    When user executes pm/measurements GET request with query params "asmpid=[props.DP_ASMPID]&starttime=[YESTERDAY.%Y-%m-%d]T00%3A00%3A00Z&endtime=[YESTERDAY.%Y-%m-%d]T00%3A00%3A01"
    Then system should return data
    """
{
"..model..isActive":"true",
"..model..serverTimestamp":"matches:(\\d\\d\\d\\d-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\dZ)",
"..model..data..timestamp[0]":"[YESTERDAY.%Y-%m-%d]T00:00:00Z",
"..model..data..waveData[0]":"matches:(\\[\\{.*\\}\\])",
"..model..data..timestamp[1]":"[YESTERDAY.%Y-%m-%d]T00:00:01Z",
"..model..data..waveData[1]":"matches:(\\[\\{.*\\}\\])"
}
"""