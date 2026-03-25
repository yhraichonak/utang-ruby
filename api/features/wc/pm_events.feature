@pm_events
Feature: PM Measurements Endpoint


  Scenario: User is able to get PM Events
    Then User is able to login into the system with valid credentials
    When user executes pm/events GET request with query params "asmpid=[props.DP_ASMPID]"
    Then system should return data
    """
{
"..model..discreteGroups..title[0]":"HR","..model..discreteGroups..textColor[0]":"2EAE2A",
"..model..discreteGroups..title[1]":"RR","..model..discreteGroups..textColor[1]":"4875B1",
"..model..discreteGroups..title[2]":"PVC","..model..discreteGroups..textColor[2]":"2EAE2A",
"..model..eventData..message[0]":"HI RR","..model..eventData..level[0]":"Medium",
"..model..eventData..discreteData[0]":"matches:(.*\"data\"=>\"80\".*\"data\"=>\"0\".*\"data\"=>\"20\".*)"
}
"""

