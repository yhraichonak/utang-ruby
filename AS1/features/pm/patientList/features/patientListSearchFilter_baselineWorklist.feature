@regression @automated @core @pm @pm-patient_list @pm-patient_list-features
Feature: PM - Patient List - Search Filter - Baseline Worklist
    On PM Census, when performing a search, patients are being returned which are on the Baseline worklist.
    Searches performed on the census should only return results within the list searched (In this case, PM Census)

    Patient A, Patient B, and Patient C are available on the census
    Patient A, Patient B, and Patient C are available on the baseline worklist
    When on the census, perform a search for Patient A - list is filtered to only show Patient A
  Navigate to Baseline worklist
  Expected: Patient A, Patient B, and Patient C are available on the baseline worklist
  Actual: Patient A is the only visible patient on the baseline worklist. User has to navigate back to the census to clear the search


  TestRail Id: C328935
  Jira Stories: AS1-2227
@critical @TMS:328935
  Scenario: PM Patient List Search Filter - Baseline Worklist
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    And I reset grouping and sorting on patients list
    Then I should see the patient list screen
    And I should see PM patient information in patientList
      | patientName          | MRN            | location            | bed            | status            | statusColor             |
      | [props.AP_FULL_NAME] | [props.AP_MRN] | [props.AP_LOCATION] | [props.AP_BED] | [props.AP_STATUS] | [props.AP_STATUS_COLOR] |

    When I enter "[props.AP_FNAME]" into the search filter
    Then I should see the patient list screen
    And I should see PM patient information in patientList
      | patientName | MRN | location | bed | status | statusColor |
    And I should see PM patient information in patientList
      | patientName          | MRN            | location            | bed            | status            | statusColor             |
      | [props.AP_FULL_NAME] | [props.AP_MRN] | [props.AP_LOCATION] | [props.AP_BED] | [props.AP_STATUS] | [props.AP_STATUS_COLOR] |


    When I click "Snippet Baseline Worklist" on the List
    Then I should see the snippet worklist screen
    And I should see PM patient information in site snippet worklist
      | patientName          | MRN            | location            | bed            | DOB                |
      | [props.AP_FULL_NAME] | [props.AP_MRN] | [props.AP_LOCATION] | [props.AP_BED] | DOB:[props.AP_DOB] |
    And I should see search filter removed

