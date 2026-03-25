@pm_trends
Feature: PM Trends Endpoint

  Scenario: User is able to get trends
    When User is able to login into the system with valid credentials
    When user executes pm/trends GET request with query params "asmpid=[props.DP_ASMPID]&keys=[props.COMMON_TRENDS_KEY]"
    Then system should return data
    """
{
"..model..interval":"60",
"..model..startTime":"matches:(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z)",
"..model..data..key":"[props.COMMON_TRENDS_KEY]",
"..model..data..values":"matches:(\\d+)"
}
"""

  Scenario: User is able to get trends with multiple keys
    When User is able to login into the system with valid credentials
    When user executes pm/trends GET request with query params "asmpid=[props.DP_ASMPID]&keys=[props.COMMON_TRENDS_KEY_MULTIPLE],[props.COMMON_TRENDS_KEY]"
    Then system should return data
    """
{
"..model..interval":"60",
"..model..startTime":"matches:(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z)",
"..model..data[0]..key":"[props.COMMON_TRENDS_KEY_MULTIPLE]",
"..model..data[0]..values":"matches:.*",
"..model..data[1]..key":"[props.COMMON_TRENDS_KEY]",
"..model..data[1]..values":"matches:.*"
}
"""

  Scenario: User is not able to get trends with false asmpid
    When User is able to login into the system with valid credentials
    When user executes pm/trends GET request with query params "asmpid=[COMMON_FALSE_ASMPID]&keys=[props.COMMON_TRENDS_KEY]"
    Then system should return data
    """
{
  "..responseCode": 100,
  "..responseError..title": "Error",
  "..responseError..details": "No session was found for asmpid=[COMMON_FALSE_ASMPID]",
  "..responseError..description": "No Session Found",
  "..model": null
}
"""

  Scenario: User is not able to get trends with invalid key
    When User is able to login into the system with valid credentials
    When user executes pm/trends GET request with query params "asmpid=[props.DP_ASMPID]&keys=[props.COMMON_TRENDS_FALSE_KEY]"
    Then system should return no data

  Scenario: User is not able to get trends with multiple keys but one key is invalid
    When User is able to login into the system with valid credentials
    When user executes pm/trends GET request with query params "asmpid=[props.DP_ASMPID]&keys=[props.COMMON_TRENDS_KEY],[props.COMMON_TRENDS_FALSE_KEY]"
    Then system should return no data