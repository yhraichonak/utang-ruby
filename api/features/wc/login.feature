@logon
Feature: LogOn Endpoint

  Scenario: User is able to log on with valid credentials
    Then User is able to login into the system with valid credentials


  Scenario Outline: User is not able to log on with invalid credentials
    When User tries to log on with username "<username>" and password "<password>"
    Then I should not receive an xAuthToken
    Examples:
      | username      | password |
      | [DU_USERNAME] |          |
      |               |          |

  Scenario: User is able to get log on status
     Given I login to the api with a valid credential
     When user executes logon/status GET request
     Then system should return response
"""
{"responseCode":"0","error":null}
"""

  Scenario: User is able to get log on status - negative
    When user executes logon/status GET request with session token "INVALID"
    Then system should return response
"""
{"responseCode":"401","error":"contains:Auth Token Invalid or Expired"}
"""