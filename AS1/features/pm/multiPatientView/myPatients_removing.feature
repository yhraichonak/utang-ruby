@automated @multiPatient @pm @pm-multi_patient_view  @TMS:580261
Feature: My Patients List - removing patients

TestRail Id: C580261
Jira Issues: AS1-2837, AS1-2847, AS1-2947, AS1-2890, AS1-2918

Background:
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  When I click "Census" on the List
  Then I should see the patient list screen
  And reset unit filtering
  And I click on patient "[props.DP_FULL_NAME]" star icon to "enabled"
  Then I should see the patient "[props.DP_FULL_NAME]" star icon "enabled"

  @critical
Scenario: My Patients - removing patients from Census
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on patient "[props.DP_FULL_NAME]" star icon to "disabled"
  Then I should see the patient "[props.DP_FULL_NAME]" star icon "disabled"
  And I should see My Patients counter decrease by "1"
  When I click "My Patients" on the List
  Then I should see the patient list screen
  And I should "not see" patient "[props.DP_FULL_NAME]" in My Patient list
  When I click the Multi-Patient View button in header
  Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
  And I should "not see" patient "[props.3LETTERFN_FULL_NAME]" condensed monitor in Multi Patient View
  When I logout of application
  Then I should see login screen
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  And I should see My Patients counter saved from previous session

Scenario: My Patients - removing patients from My Patients
  When I click "My Patients" on the List
  Then I should see the patient list screen
  When I click on patient "[props.DP_FULL_NAME]" star icon to "disabled"
  Then I should see My Patients counter decrease by "1"
  Then I should see the patient "[props.DP_FULL_NAME]" star icon "disabled"
  When I click the Multi-Patient View button in header
  Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
  And I should "not see" patient "[props.3LETTERFN_FULL_NAME]" condensed monitor in Multi Patient View
  When I click the back button in the Header
  Then I should see the patient list screen
  And I should "not see" patient "[props.DP_FULL_NAME]" in My Patient list
  When I get my patient count
  And I logout of application
  Then I should see login screen
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  And I should see My Patients counter saved from previous session

Scenario: My Patients - removing patients from Multi Patient View
  When I click "My Patients" on the List
  Then I should see the patient list screen
  When I click the Multi-Patient View button in header
  Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
  When I click to "enable" the Hide PHI button
  Then I should see the Hide PHI button highlighted
  And I should "see" patient "[props.3LETTERFN_FULL_NAME]" condensed monitor in Multi Patient View
  When I click on patient "[props.3LETTERFN_FULL_NAME]" condensed monitor close button
  Then I should "not see" patient "[props.3LETTERFN_FULL_NAME]" condensed monitor in Multi Patient View
  When I click to "disable" the Hide PHI button
  Then I should see the Hide PHI button not highlighted
  When I click the back button in the Header
  Then I should see the patient list screen
  And I should "not see" patient "[props.DP_FULL_NAME]" in My Patient list
  And I should see My Patients counter decrease by "1"
  When I get my patient count
  And I logout of application
  Then I should see login screen
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  And I should see My Patients counter saved from previous session
