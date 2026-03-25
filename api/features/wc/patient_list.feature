@patientlist
Feature: Patient list Endpoint

  Background:
    Given I login to the api with a valid credential
    Then I should receive an xAuthToken
    When I execute a version API call

  Scenario: User is able to get Patient List  data
    When user executes patientlist GET request
    Then system should return patient
    """
{
  "asmpid":"matches:.{8}-.{4}-.{4}-.{4}-.{12}",
  "lastName":"[props.DP_LNAME]",
  "firstName":"[props.DP_FNAME]",
  "mrn":"[props.DP_MRN]",
  "age":"[props.DP_AGE]",
  "dateOfBirth":"[props.DP_DOB_TIMESTAMP]",
  "gender":"[props.DP_SEX_FULL]",
  "status":"[props.DP_STATUS]",
  "location":"[props.DP_LOCATION]",
  "unit":"[props.DP_UNIT]"
}
"""

  Scenario: User is able to get Patient List  data - List type
    When user executes patientlist GET request with query params "listType=snippetsworklist"
    Then system should return patient
    """
{
  "asmpid":"matches:.{8}-.{4}-.{4}-.{4}-.{12}",
  "lastName":"[props.DP_LNAME]",
  "firstName":"[props.DP_FNAME]",
  "mrn":"[props.DP_MRN]",
  "age":"[props.DP_AGE]",
  "dateOfBirth":"[props.DP_DOB_TIMESTAMP]",
  "gender":"[props.DP_SEX_FULL]",
  "status":"[props.DP_STATUS]",
  "location":"[props.DP_LOCATION]"
}
"""

  Scenario: User is able to get Patient List  data - List type & ID
    When user executes patientlist GET request with query params "listType=snippetsworklist&listId=1"
    Then system should return patient
    """
{
  "asmpid":"matches:.{8}-.{4}-.{4}-.{4}-.{12}",
  "lastName":"[props.SNPWP_LNAME]",
  "firstName":"[props.SNPWP_FNAME]",
  "mrn":"[props.SNPWP_MRN]",
  "age":"[props.SNPWP_AGE]",
  "dateOfBirth":"[props.SNPWP_DOB_TIMESTAMP]",
  "gender":"[props.SNPWP_SEX]",
  "status":"[props.SNPWP_STATUS]",
  "location":"[props.SNPWP_BED]",
  "groupId":"1"
}
"""

  Scenario Outline: User is able to get Patient List  data - Search
    When user searches for patients with params "searchkey1=<search1>&searchkey2=<search2>&searchkey3=<search3>&searchkey5=<search5>"
    Then system should return patient
    """
{
  "asmpid":"matches:.{8}-.{4}-.{4}-.{4}-.{12}",
  "lastName":"[props.DP_LNAME]",
  "firstName":"[props.DP_FNAME]",
  "mrn":"[props.DP_MRN]",
  "dateOfBirth":"[props.DP_DOB_TIMESTAMP]",
  "gender":"[props.DP_SEX_FULL]"
}
  """
    Examples:
      | search1          | search2          | search3                 | search5        |
      | [props.DP_FNAME] |                  |                         |                |
      |                  | [props.DP_LNAME] |                         |                |
      |                  |                  | [props.DP_DOB_MMDDYYYY] |                |
      |                  |                  |                         | [props.DP_MRN] |
      | [props.DP_FNAME] |                  |                         | [props.DP_MRN] |
      | [props.DP_FNAME] | [props.DP_LNAME] |                         | [props.DP_MRN] |

  @ISSUE:AS1-7407
  Scenario: User is able to get Patient List  data - Search by age
    When user searches for patients with params "searchkey4=[props.DP_AGE]"
    Then system should return patient
    """
{
  "asmpid":"matches:.{8}-.{4}-.{4}-.{4}-.{12}",
  "lastName":"[props.DP_LNAME]",
  "firstName":"[props.DP_FNAME]",
  "mrn":"[props.DP_MRN]",
  "age":"contains:[props.DP_AGE]",
  "dateOfBirth":"[props.DP_DOB_TIMESTAMP]",
  "gender":"[props.DP_SEX_FULL]"
}
  """


  Scenario: User is able to get Patient List  data - Search - Multiple result
    When user searches for patients with params "searchkey4=21"
    Then system should return 2 patients

  Scenario: User is able to get Patient List  data - Search - No result
    When user searches for patients with params "searchkey4=999"
    Then system should return 0 patients

  Scenario: User is able to get Patient List configuration data
    When user executes patientlist/configuration GET request
    Then system should return patient list configuration
    """
{
  "lists..title[0]":"Census",  "lists..type[0]":"census",
  "lists..title[1]":"Snippet Worklist","lists..type[1]":"snippetsworklist",
  "lists..title[2]":"Monitor Tech 1","lists..type[2]":"snippetsworklist",
  "lists..title[3]":"Monitor Tech 2","lists..type[3]":"snippetsworklist",
  "lists..title[4]":"Snippet Baseline Worklist","lists..type[4]":"snippetsbaselineworklist",
  "lists..title[5]":"MOST RECENT","lists..type[5]":"mostrecent",
  "lists..title[6]":"EMS","lists..type[6]":"ems",
  "lists..title[7]":"SEARCH","lists..type[7]":"search",
  "lists..title[8]":"SECURE MESSAGING","lists..type[8]":"securemessaging",
  "lists..title[9]":"NOTIFICATIONS","lists..type[9]":"notification"
}
"""
