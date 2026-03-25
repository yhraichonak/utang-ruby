@smoke @multiPatient @automated @core @pm @pm-patient_list @pm-patient_list-features  @TMS:580271
Feature: My Patients List - navigation

  TestRail Id: C580271
  Jira Epic: AS1-2837
  Jira Stories:
  Jira Bugs/Defects: AS1-2944, AS1-7126

  @critical
  Scenario: My Patients - navigation
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    And reset unit filtering
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on patient "[props.NMP2_FULL_NAME]" star icon to "disabled"
    Then I should see the patient "[props.NMP2_FULL_NAME]" star icon "disabled"
    When I click on patient "[props.NMP2_FULL_NAME]" star icon to "enabled"
    Then I should see the patient "[props.NMP2_FULL_NAME]" star icon "enabled"
    And I should see My Patients counter increase by "1"
    When I click "My Patients" on the List
    Then I should see the patient list screen

    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see patients demographics, location, alarms, and 1 waveform with parameters in each condensed monitor
    When I click the Home icon
    And I click "Census" on the List
    Then I should see the patient list screen

# TODO: fix as it breaks common username user
  Scenario: My Patients - no my patients
    Given I login to a testSite with "username" and "XXXXX"
    Then I should see the patient list screen
    And reset unit filtering
    When I click "My Patients" on the List
    And I configure My Patients list to have "0" patients
    And I click "Census" on the List
    Then I should see the patient list screen
    When I get my patient count
    And I logout of application
    Then I should see login screen
    Given I login to a testSite with "username" and "XXXXX"
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    And reset unit filtering
    When I click on patient "[props.DP_FULL_NAME]" star icon to "enabled"
    Then I should see the patient "[props.DP_FULL_NAME]" star icon "enabled"
    When I click on patient "[props.AP_FULL_NAME]" star icon to "enabled"
    Then I should see the patient "[props.AP_FULL_NAME]" star icon "enabled"
    And I should see My Patients counter with count of "2"
    When I click "OR Floor 2" on the List
    Then I should be on "OR Floor 2" patientList
    And I should see the patient list screen
    And I should see My Patients counter with count of "2"
    When I click "My Patients" on the List
    Then I should see the patient list screen
    And I should see patient "[props.DP_FULL_NAME]" in My Patient list
    And I should see patient "[props.AP_FULL_NAME]" in My Patient list
