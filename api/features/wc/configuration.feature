@config
Feature: Configuration Endpoint

  Scenario: User is able to get User Configuration data
    Given I login to the api with a valid credential
    When user executes aso/configuration/userconfiguration GET request
    When system should return user config
    """
{
  "client.pm.groupSort.groupBy":"[props.DUC_GROUP_BY]",
  "client.pm.groupSort.sortBy1":"[props.DUC_SORT_BY]",
  "client.pm.sweep":"true",
  "client.pm.workList.singleColumn":"true",
  "client.pm.paperMode":"true",
  "client.pm.filterUnits.[props.DUC_UNIT1]":"true",
  "client.pm.filterUnits.[props.DUC_UNIT2]":"true",
  "client.pm.filterUnits.[props.DUC_UNIT3]":"true",
  "client.pm.filterUnits.[props.DUC_UNIT4]":"true",
  "client.pm.filterUnits.[props.DUC_UNIT5]":"true",
  "client.pm.filterUnits.[props.DUC_UNIT6]":"true",
  "client.pm.filterUnits.[props.DUC_UNIT7]":"true",
  "client.pm.filterUnits.[props.DUC_UNIT8]":"true",
  "client.pm.filterUnits.[props.DUC_UNIT9]":"true",
  "client.pm.filterUnits.[props.DUC_UNIT10]":"true",
  "client.pm.filterUnits.[props.DUC_UNIT11]":"true",
  "client.pm.filterUnits.[props.DUC_UNIT12]":"true",
  "client.pm.filterUnits.[props.DUC_UNIT13]":"true",
  "client.pm.showPHI":"true",
    "..snippetsReport..columns..Header[0]":"Status",        "..snippetsReport..columns..visible[0]":"true", "..snippetsReport..columns.._filterValues[0]":"[]",
    "..snippetsReport..columns..Header[1]":"Patient Name",  "..snippetsReport..columns..visible[1]":"true", "..snippetsReport..columns.._filterValues[1]":"[]",
    "..snippetsReport..columns..Header[2]":"MRN",           "..snippetsReport..columns..visible[2]":"true", "...snippetsReport.columns.._filterValues[2]":"[]",
    "..snippetsReport..columns..Header[3]":"Unit",          "..snippetsReport..columns..visible[3]":"true",
    "..snippetsReport..columns..Header[4]":"Bed",           "..snippetsReport..columns..visible[4]":"true", "..snippetsReport..columns.._filterValues[4]":"[]",
    "..snippetsReport..columns..Header[5]":"Captured By",   "..snippetsReport..columns..visible[5]":"true", "..snippetsReport..columns.._filterValues[5]":"[]",
    "..snippetsReport..columns..Header[6]":"Date/Time of Strip","..snippetsReport..columns..visible[6]":"true", "..snippetsReport..columns.._filterValues[6]":"[]",
    "..snippetsReport..columns..Header[7]":"Event Description", "..snippetsReport..columns..visible[7]":"true", "..snippetsReport..columns.._filterValues[7]":"[]",
    "..snippetsReport.columns..Header[8]":"Snippet Type",  "..snippetsReport..columns..visible[8]":"true", "..snippetsReport..columns.._filterValues[8]":"[]",
    "..snippetsReport..columns..Header[9]":"Reviewed By",   "..snippetsReport..columns..visible[9]":"true", "..snippetsReport..columns.._filterValues[9]":"[]",
    "..snippetsReport..columns..Header[10]":"Status",       "..snippetsReport..columns..visible[10]":"true", "..snippetsReport..columns.._filterValues[10]":"[]",
    "..snippetsReport..dateFilter..start":"matches:\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}",
    "..snippetsReport..bedFilter..start":"",
    "..snippetsReport..bedFilter..end":"",
    "..snippetsReport..checkedLocations[0]":"matches:.*unit.*all.*",
    "..snippetsReport..checkedLocations[0]":"matches:.*unit.*\"\".*",
    "..snippetsReport..checkedLocations[0]":"matches:.*unit.*5E.*",
    "..snippetsReport..checkedLocations[0]":"matches:.*unit.*ALARM.*",
    "..snippetsReport..checkedLocations[0]":"matches:.*unit.*ATQA.*",
    "..snippetsReport..checkedLocations[0]":"matches:.*unit.*CCU.*",
    "..snippetsReport..checkedLocations[0]":"matches:.*unit.*ICU.*",
    "..snippetsReport..checkedLocations[0]":"matches:.*unit.*LTAC.*",
    "..snippetsReport..checkedLocations[0]":"matches:.*unit.*ONC.*",
    "..snippetsReport..checkedLocations[0]":"matches:.*unit.*SU.*",
    "..snippetsReport..checkedLocations[0]":"matches:.*unit.*DISCHARGED.*",
    "..snippetsReport..includePurgePending":"false",
      "server.pm.censusSort":"UNIT_ROOM",
      "server.pm.snippetsEnabled":"true",
      "server.pm.dualLead":"false",
      "server.pm.snippetsDurations":[6, 10, 30, 60, 120],
      "server.pm.mostRecentPatientListLength":0,
      "server.pm.dataRangeInHours":"matches:(72|192)",
      "server.pm.snippetsShowStatementCodes":true,
      "server.pm.snippetsEnableDescriptionFreeText":true,
      "server.pm.snippetsEnableEditableMeasurementText":true,
      "server.pm.exportSupervisorReport":false,
      "server.pm.exportSupervisorReportPromptText":"Warning: Data is not to be removed from the hospital network",
      "server.pm.privileges":["ACCESS_MULTIVIEW"],
        "server.messaging.messagingEnabled":true,
        "server.messaging.sharingEnabled":true,
        "server.messaging.conversationDeleteEnabled":true,
        "server.messaging.contactId":10,
        "server.messaging.privileges":[],
          "server.ob.mostRecentPatientListLength":10,
              "server.cardio.mostRecentPatientListLength":10,
              "server.cardio.acknowledgeWorkflowAction.presentTense":"View",
              "server.cardio.acknowledgeWorkflowAction.pastTense":"Viewed",
              "server.cardio.acknowledgeWorkflowRemarks":["ECG COMMENT 1", " ECG COMMENT 2", " ECG COMMENT 3", " ECG COMMENT NUMBER 4"],
                 "server.emr.mostRecentPatientListLength":10,
                       "server.displayName":"Web Tester",
                       "server.lastName":"Tester",
                       "server.firstName":"Web"
}
"""


  Scenario Outline: User is able to post User Configuration data
    Then it should login to the api as user "[props.DEU_USERNAME]" with password "[props.DEU_PASSWORD]"
    When user updates user configuration
    """
    <edit>
    """
    And it should login to the api as user "[props.DEU_USERNAME]" with password "[props.DEU_PASSWORD]"
    Then user verifies the user config attributes
    """
    <verification>
    """
    Examples:
      | edit                                                                       | verification                           |
      | {"['userPreferences']['client']['pm']['sweep']":false  }                   | {"client.pm.sweep":false}              |
      | { "['userPreferences']['client']['pm']['groupSort']['groupBy']":"'UNIT'" } | {"client.pm.groupSort.groupBy":"UNIT"} |

  Scenario: User is able to get Search field configuration
    Given I login to the api with a valid credential
    When user executes configuration/searchfields GET request
    Then system should return user config
    """
    {"..fieldId[0]":"firstname","..label[0]":"First", "..fieldId[1]":"lastname","..label[1]":"Last",
     "..fieldId[2]":"bed","..label[2]":"Bed", "..fieldId[3]":"mrn","..label[3]":"MRN"}
    """