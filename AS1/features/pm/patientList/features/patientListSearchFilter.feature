@regression @automated @core @pm @pm-patient_list @pm-patient_list-features
Feature: PM - Patient List - Search Filter
  From the PM Patient List, Users can perform a simple search.


  TestRail Id: C264310
  Jira Stories: AS1-122, AS1-673, AS1-1189, AS1-1089, AS1-2620, AS1-3673, AS1-3853, AS1-4120
  @critical @TMS:264310
  Scenario: PM Patient List Search Filter
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    And I set group by to "Unit"
    And I should see the patient search box center aligned on screen
    And I should see PM patient information in patientList
      | patientName          | gender         | age            | MRN            | DOB                  | location            | bed           | status           | statusColor             |
      | [props.CP_FULL_NAME] | [props.CP_SEX] | [props.CP_AGE] | [props.CP_MRN] | DOB:  [props.CP_DOB] | [props.CP_LOCATION] | [props.CP_BED]| [props.CP_STATUS] | [props.CP_STATUS_COLOR] |
    When I enter "[props.DP_LNAME]" into the search filter
    Then I should see the patient list screen
    And I should see PM patient information in patientList
      | patientName          | gender         | age            | MRN            | DOB                  | location            | bed           | status           | statusColor             |
      | [props.DP_FULL_NAME] | [props.DP_SEX] | [props.DP_AGE] | [props.DP_MRN] | DOB:  [props.DP_DOB] | [props.DP_LOCATION] | [props.DP_BED]| [props.DP_STATUS] | [props.DP_STATUS_COLOR] |

    When I enter "[props.CP_BED]" into the search filter
    Then I should see the patient list screen
    And I should see PM patient information in patientList
      | patientName          | gender         | age            | MRN            | DOB                  | location            | bed           | status           | statusColor             |
      | [props.CP_FULL_NAME] | [props.CP_SEX] | [props.CP_AGE] | [props.CP_MRN] | DOB:  [props.CP_DOB] | [props.CP_LOCATION] | [props.CP_BED]| [props.CP_STATUS] | [props.CP_STATUS_COLOR] |

    When I enter "[props.DP_LOCATION]" into the search filter
    Then I should see the patient list screen
    And I should see PM patient information in patientList
      | patientName          | gender         | age            | MRN            | DOB                  | location            | bed           | status           | statusColor             |
      | [props.DP_FULL_NAME] | [props.DP_SEX] | [props.DP_AGE] | [props.DP_MRN] | DOB:  [props.DP_DOB] | [props.DP_LOCATION] | [props.DP_BED] | [props.DP_STATUS] | [props.DP_STATUS_COLOR] |

    When I enter "[props.CP_MRN]" into the search filter
    Then I should see the patient list screen
    And I should see PM patient information in patientList
      | patientName          | gender         | age            | MRN            | DOB                  | location            | bed           | status           | statusColor             |
      | [props.CP_FULL_NAME] | [props.CP_SEX] | [props.CP_AGE] | [props.CP_MRN] | DOB:  [props.CP_DOB] | [props.CP_LOCATION] | [props.CP_BED] | [props.CP_STATUS]| [props.CP_STATUS_COLOR] |

    When I enter "[props.DP_FNAME]" into the search filter
    Then I should see the patient list screen
    And I should see PM patient information in patientList
      | patientName          | gender         | age            | MRN            | DOB                  | location            | bed           | status           | statusColor             |
      | [props.DP_FULL_NAME] | [props.DP_SEX] | [props.DP_AGE] | [props.DP_MRN] | DOB:  [props.DP_DOB] | [props.DP_LOCATION] | [props.DP_BED] | [props.DP_STATUS]| [props.DP_STATUS_COLOR] |

    When I click on "[props.DP_FULL_NAME]" in patient list
    Then I should see the patient summary screen
    When I click the Back button in PM patient header
    Then I should see the patient list screen
    And I should see PM patient information in patientList
      | patientName          | gender         | age            | MRN            | DOB                  | location            | bed           | status           | statusColor             |
      | [props.DP_FULL_NAME] | [props.DP_SEX] | [props.DP_AGE] | [props.DP_MRN] | DOB:  [props.DP_DOB] | [props.DP_LOCATION] | [props.DP_BED]| [props.DP_STATUS] | [props.DP_STATUS_COLOR] |

    And I should see "[props.DP_FNAME]" in the search filter
