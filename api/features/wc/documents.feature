@documents
Feature: Documents Endpoint

  Scenario: User is able to get document labels
    Then User is able to login into the system with valid credentials
    When user executes aso/document/documentlabels GET request
    Then system should return data
    """
{
"..model..snippetDocumentTypes..0":"PRN",
"..model..snippetDocumentTypes..1":"Admission Baseline",
"..model..snippetDocumentTypes..2":"Shift Assessment",
"..model..snippetDocumentTypes..3":"EVENT"
}
"""


  Scenario: User is able to get report locations
    Then User is able to login into the system with valid credentials
    When user executes aso/document/reportlocations GET request
    Then system should return data
    """
{
"..unit[0]":"",
"..unit[1]":"[props.DUC_UNIT1]",
"..unit[2]":"[props.DUC_UNIT2]",
"..unit[3]":"[props.DUC_UNIT3]",
"..unit[4]":"[props.DUC_UNIT4]",
"..unit[5]":"[props.DUC_UNIT5]",
"..unit[6]":"[props.DUC_UNIT6]",
"..unit[7]":"[props.DUC_UNIT7]",
"..unit[8]":"[props.DUC_UNIT8]",
"..unit[9]":"[props.DUC_UNIT9]",
"..unit[10]":"[props.DUC_UNIT10]"
}
"""

  Scenario: User is able to get nurse report
    Then User is able to login into the system with valid credentials
    When user executes aso/document/nursereport GET request with query params "fromDate=2023-05-11&units=[props.DP_UNIT]&includePurgePending=false"
    Then system should return data
    """
{
"..documentId[0]":"matches:\\d+",
"..asmpid[0]":"matches:.*",
"..firstName[0]":"matches:.*",
"..lastName[0]":"matches:.*",
"..mrn[0]":"matches:.*",
"..author[0]":"matches:.*",
"..createdTime[0]":"matches:.*",
"..eventDescriptions[0]":"matches:.*",
"..snippetType[0]":"3",
"..status[0]":"matches:(Unapproved|Rejected|Approved|Saved)",
"..reviewedBy[0]":"matches:.*",
"..location[0]":"matches:.*",
"..facilityCode[0]":"",
"..isPurgePending[0]":"false"
}
"""


#Scenario: User is able to get nurse report custom grouping
#  Then User is able to login into the system with valid credentials
#  When user updates user configuration
#  """
#  {"['userPreferences']['client']['snippetsReport']['columns'][0]['_filterValues']":["Approved"]}
#  """
#  When user executes aso/document/nursereport GET request with query params "fromDate=2023-05-11&units=[props.DP_UNIT]&includePurgePending=false"
#  Then system should return data
#    """
#{"..status[0]":"matches:Approved"}
#"""

  Scenario: User is able to get document content
    Given User is logged into the system with valid credentials
    When user executes aso/document/Document GET request with query params "documentid=[props.COMMON_DOCUMENT_ID]&asmpid=99999"
    Then system should return data
    """
{
  "..documentId": [props.COMMON_DOCUMENT_ID],
  "..title": "[props.COMMON_DOCUMENT_TITLE]",
  "..format": "[props.COMMON_DOCUMENT_FORMAT]",
  "..type": "[props.COMMON_DOCUMENT_TYPE]",
  "..updatedTime": "matches:(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}-\\d{2}:\\d{2})",
  "..createdTime": "matches:(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}-\\d{2}:\\d{2})",
  "..body": "matches:.*",
  "..authorName": "matches:.*[props.COMMON_DOCUMENT_AUTHOR].*",
  "..status": [props.COMMON_DOCUMENT_STATUS]
}
"""

  Scenario: User is not able to get document content with invalid document id
    Given User is logged into the system with valid credentials
    When user executes aso/document/Document GET request with query params "documentid=[props.COMMON_FALSE_DOCUMENT_ID]&asmpid=99999"
    Then system should return data
    """
{
  "..documentId":null,
  "..title": null,
  "..format": null,
  "..type": null,
  "..updatedTime": null,
  "..createdTime": null,
  "..body": null,
  "..authorName": null,
  "..status": null
}
"""

  Scenario: User is able to post document approval
    Given User is able to login into the system with valid credentials
    And a snippet has been created by the user for asmpid "[props.DP_ASMPID]"
    And User is logged into the system as superuser
    When user executes aso/post/snippets/ [props.COMMON_DOCUMENT_ID] /approve POST request
    Then system should return data
    """
{
  "..model": null,
  "..error": null
}
"""

  Scenario: User is not able to post document approval with invalid document id
    Given User is logged into the system as superuser
    When user executes aso/post/snippets/ [props.COMMON_FALSE_DOCUMENT_ID] /approve POST request
    Then system should return data
    """
{
  "..error..title": "GeneralError",
  "..error..description": "Unable to approve snippet.",
  "..error..details": "matches:.*"
}
"""

  Scenario: User is not able to post document approval because account doesn't have approve/reject permission
    Given User is logged into the system with valid credentials
    When user executes aso/post/snippets/ [props.COMMON_FALSE_DOCUMENT_ID] /approve POST request
    Then system should return data
    """
{
  "..error..title": "GeneralError",
  "..error..description": "Unable to approve snippet.",
  "..error..details": "matches:.*"
}
"""

  Scenario: User is not able to post document rejection with invalid document id
    Given User is logged into the system as superuser
    When user executes aso/post/snippets/ [props.COMMON_FALSE_DOCUMENT_ID] /reject POST request
    Then system should return data
    """
{
  "..error..title": "GeneralError",
  "..error..description": "Unable to reject snippet.",
  "..error..details": "matches:.*"
}
"""

  Scenario: User is able to post document rejection
    Given User is able to login into the system with valid credentials
    And a snippet has been created by the user for asmpid "[props.DP_ASMPID]"
    Given User is logged into the system as superuser
    When user executes aso/post/snippets/ [props.COMMON_DOCUMENT_ID] /reject POST request
    Then system should return data
    """
{
  "..model": null,
  "..error": null
}
"""