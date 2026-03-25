@operationlog
Feature: Operation log Endpoint

  Scenario: User is able to set operation log
    Given I login to the api with a valid credential
    And Remember "[UNIQUE]" value as "index" test data value
    And user executes aso/post/operationlog/logoperation POST request with attributes
    """
  {
  "type": "web-as1-gen2 v4.1.0",
  "operationType": "multiPatientViewed",
  "context": "[env.SERVER_URL]patients/surveil/0",
  "extraContext": {
    "component": "PM MPV",
    "atinfo":"[td.index]",
    "user": "utang",
    "timestamp": "2023-05-05T05:05:05.005Z"
  }
}
    """
    Then system should create operation log item in DB with text "[td.index]"