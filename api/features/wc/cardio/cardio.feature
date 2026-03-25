@cardio
Feature: Cardio Endpoint

  Scenario Outline: User is able to turn ON/OFF cardio notifications settings
    Given User is logged into the system with valid credentials
    When user executes cardio/setuseravailabilitynotifications GET request with query params "is-available-for-notifications=<status>"
    And user executes cardio/isuseravailablefornotifications GET request
    Then system should return data
    """
{"..model":"<status>"}
"""
    Examples:
      | status |
      | false  |
      | true   |

  Scenario: User is able to get Cardio Statement Library
    Given User is logged into the system with valid credentials
    And user executes cardio/statementlibrary GET request
    Then system should return data
    """
{
"..code[0]":"SNF","..number[0]":1,"..text[0]":"STATEMENT NOT FOUND",
"..code[1]":"PEDANL","..number[1]":2,"..text[1]":"** * Pediatric ECG analysis * **",
"..code[599]":"STDEP+","..number[599]":1011,"..text[599]":"ST depression occurred at a higher work level"
}
"""
  @skip
  #TODO: Implement ECG Notifications on test env
  Scenario: User is able to Acknowledge Notificaiton
    Given User is logged into the system with valid credentials
    And The user notification has been configured for the asmpid "[props.DP_ASMPID]"
    When user executes cardio/post/ecgacknowledgment POST request with query params "asmpid=[props.DP_ASMPID]" for the configured notification
    Then system should return data
    """
    {
    "..responseCode":0,
    "..requestAccepted":0,
    "..acknowledgedBy":"matches:.*",
    "..acknowledgedTimestamp":"matches:(\\d\\d\\d\\d-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\d-\\d\\d:\\d\\d)",
     }
     """


  Scenario: User is able not to Acknowledge Notificaiton with invalid notification id
    Given User is logged into the system with valid credentials
    When user executes cardio/post/ecgacknowledgment POST request with query params "asmpid=[props.DP_ASMPID]&notificationid=999"
    Then system should return data
    """
  {"..responseCode":100, "..title":"Unable To Accept Notification", "..description":"Missing or invalid Parameter: notificationid"}
  """

   @skip
  #TODO: Clarify cardio ecg v2 API. Depends on  ECG Notifications
  Scenario: User is able is able to get all ecg status
    Given User is logged into the system with valid credentials
    When user executes cardio/v2/getallecgstatus GET request
    Then system should return data
    """
  {"..unfilteredEcgCount":"matches:\\d*"}
  """

  @skip
  #TODO: Clarify cardio ecg v2 API. Depends on ECG Notification
  Scenario: User is able is able to get ECG notification status ecg status
    Given User is logged into the system with valid credentials
    When user executes cardio/v2/getecgnotificationstatus GET request
    Then system should return data
    """
  {"..unfilteredEcgCount":"matches:\\d*"}
  """


  Scenario: User is able is able to get ECG notification status ecg status
    Given User is logged into the system with valid credentials
    When user executes cardio/v2/getusersavailablefornotifications GET request
    Then system should return user
    """
{
  "userName":"[props.DU_USERNAME]",
   "fullName":"[props.DU_FULL_NAME2]",
    "userId":"matches:\\d+",
     "moduleInstanceConfigurationIds":"matches:\[.*\\d+.*\]"
}
"""


  Scenario: User is able is able to confirm ECG - one statement
    Given User is logged into the system as superuser
    And user executes cardio/post/ecg/confirm POST request with query params "ecgid=[props.DP_ECGID_EDIT]" and attributes
    """
    [[{ "statementCode":"NSR",
        "statementText":"Normal sinus rhythm",
        "number":22,
        "compoundText":null,
        "isCompoundStatement":false}]]
    """
    Then system should return data
    """
    {"..userMessage":"Test Has Been Updated"}
    """
    And verify cardio ECG "[props.DP_ECGID_EDIT]" statement with asmpId "[props.DP_ASMPID]"
    """
    {"..statements..statementCode[0]":"NSR",
    "..statements..number[0]":22,
    "..statements..statementText[0]":"Normal sinus rhythm",
    "..statements..compoundText[0]":null,
    "..statements..isCompoundStatement[0]":false}
    """



  Scenario: User is able is able to confirm ECG - several one-line statements
    Given User is logged into the system as superuser
    And user executes cardio/requestedit GET request with query params "ecgid=[props.DP_ECGID_EDIT]"
    And user executes cardio/post/ecg/confirm POST request with query params "ecgid=[props.DP_ECGID_EDIT]" and attributes
    """
  [[{ "statementCode":"NSR",
      "statementText":"Normal sinus rhythm",
      "number":22,
      "compoundText":null,"isCompoundStatement":false},
      {"statementCode":"SBRAD",
        "statementText":"Sinus bradycardia",
        "number":21}]]
    """
    Then system should return data
    """
    {"..userMessage":"Test Has Been Updated"}
    """
    And verify cardio ECG "[props.DP_ECGID_EDIT]" statement with asmpId "[props.DP_ASMPID]"
    """
    {"..statements..statementCode[0]":"NSR",
    "..statements..number[0]":22,
    "..statements..statementText[0]":"Normal sinus rhythm",
    "..statements..compoundText[0]":null,
    "..statements..isCompoundStatement[0]":false,
    "..statements..statementCode[1]":"SBRAD",
    "..statements..number[1]":21,
    "..statements..statementText[1]":"Sinus bradycardia"}
    """


  Scenario: User is able is able to confirm ECG - several multi-line statements
    Given User is logged into the system as superuser
    And user executes cardio/post/ecg/confirm POST request with query params "ecgid=[props.DP_ECGID_EDIT]" and attributes
    """
  [
  [{"statementCode":"NSR", "statementText":"Normal sinus rhythm", "number":22,"compoundText":null,"isCompoundStatement":false}],
  [{"statementCode":"SBRAD","statementText":"Sinus bradycardia","number":21}]]
    """
    And verify cardio ECG "[props.DP_ECGID_EDIT]" statement with asmpId "[props.DP_ASMPID]"
    """
    {"..statements..statementCode[0]":"NSR",
    "..statements..number[0]":22,
    "..statements..statementText[0]":"Normal sinus rhythm",
    "..statements..compoundText[0]":null,
    "..statements..isCompoundStatement[0]":false,
    "..statements..statementCode[1]":"SBRAD",
    "..statements..number[1]":21,
    "..statements..statementText[1]":"Sinus bradycardia"}
    """

  Scenario: User is able is able to confirm ECG - several custom multi-line statements
    Given User is logged into the system as superuser
    And user executes cardio/post/ecg/confirm POST request with query params "ecgid=[props.ECGEDITP_ECGID]" and attributes
    """
    [[{"statementText":"statement1"}],[{"statementText":"statement2"}]]
    """
    And verify cardio ECG "[props.ECGEDITP_ECGID]" statement with asmpId "[props.ECGEDITP_ASMPID]"
    """
    {"..statements..statementText[0]":"statement1",
    "..statements..statementText[1]":"statement2"}
    """

  Scenario: User is able is able to confirm ECG - several custom same-line statements
    Given User is logged into the system as superuser
    And user executes cardio/post/ecg/confirm POST request with query params "ecgid=[props.ECGEDITP_ECGID]" and attributes
    """
    [[{"statementText":"statement1"},{"statementText":"statement2"}]]
    """
    And verify cardio ECG "[props.ECGEDITP_ECGID]" statement with asmpId "[props.DP_ASMPID]"
    """
    {"..statements..statementText[0]":"statement1",
    "..statements..statementText[1]":"statement2"}
    """