@multiPatient @automated    @pm @pm-multi_patient_view
Feature: Multi-Patient View - Group By/Sort By 
Group/Sort:
The user may group or sort a patient list.
Default Sort by Bed
Default Sort is Left to right, top to bottom

TestRail Id: C580257
Jira Issues: AS1-2815, AS1-2881, AS1-2900
@critical @TMS:580257
Scenario: Multi-Patient View - Group By/Sort By
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  And I clear grouping on patients list
  When I click "My Patients" on the List
  Then I should see the patient list screen
  When I click the Multi-Patient View button in header
  Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
  And I should see the Group Sort link active
  When I click the Home icon
  Then I should see the patient list screen
  And I should be on "My Patient" patientList
  And I should see the Group Sort link active
  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted
  When I click the Multi-Patient View button in header
  Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
  And I should see the Group Sort link active
  When I click on Group/Sort link
  And I click the reset button on Group / Sort window
  Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
  When I click on Group/Sort link
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
  When I click the Home icon
  Then I should see the patient list screen
  And I should be on "My Patient" patientList
  And I should see the Group Sort link active
  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted
  When I click the Home icon
  Then I should see the patient list screen
  And I should be on "My Patient" patientList
  And I should see the Group Sort link active
  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "MRN"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted
  When I click the Home icon
  Then I should see the patient list screen
  And I should be on "My Patient" patientList
  And I should see the Group Sort link active

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click the reset button on Group / Sort window
  Then I should see the Group Sort link not highlighted