@smoke @multiPatient @nodeSim @regression @automated    @pm @pm-multi_patient_view
Feature: Multi-Patient View - hide PHI button

PHI HIDE/SHOW Toggle
The Multi-Patient View can be set to Show or Hide display of Patient Health Information via the TBD User drop-down control PHI Toggle.
The toggle label should display "Hide PHI" PHI HIDE/SHOW mode of the Multi-Patient View simply means that the user of the MPV needs
to display the Multi-Patient View in an area of the hospital that non-hospital staff can see - therefore PHI (Patient Health Information)
needs to be hidden. The simplest way to do this while retaining the usefulness of the existing functionality is to "hide" the full patient name.

when the Multi-Patient is set to Hide PHI (Toggle ON):
Anywhere a Patient name ("Last, First") is displayed - switch to displaying only the first three letters of the patient's first and last name
(where patient name is "Last, First" the Hide PHI toggle ON would show "LAS, FIR") 

This setting should retain state across sessions (stored in user preferences).

PHI Hide/Show Toggle Location
PHI Hide/Show toggle will appear Right aligned in the Secondary Navigation Space (with all other MPV 'view' buttons, farthest to the right)
Note: Will be in PLACE of search as the right-most MPV item (see associated JIRA)

TestRail Id: C580706
Jira Issues: AS1-2923
 @critical @TMS:580706
Scenario: Multi-Patient View - hide PHI button
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  # Then I should see the patient list screen 
  # When I click "My Patients" on the List 
  ##
  # (I disabled these steps because it will fail if "My Patients" 
  # is empty. The test works just fine on the census. You just 
  # get the "Too many beds warning")
  Then I should see the patient list screen
  When I click the Multi-Patient View button in header 
  Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
  And I should see the Hide PHI button in header
  
  When I click to "enable" the Hide PHI button
  Then I should see the Hide PHI button highlighted
  And I should see the all patients name switch to displaying only the first three letters of the patient first and last name
  
  When I click to "disable" the Hide PHI button
  Then I should see the Hide PHI button not highlighted
  And I should see the full patient names in the displaying on screen
  
  When I click to "enable" the Hide PHI button
  Then I should see the Hide PHI button highlighted
  And I should see the all patients name switch to displaying only the first three letters of the patient first and last name
  
  When I click on individual condensed patient monitor on Multi Patient View screen
  Then I should see the selected patient monitor open below Multi Patient View in split screen mode
  And I should see the Hide PHI button highlighted
  And I should see the all patients name switch to displaying only the first three letters of the patient first and last name  
  
  When I click on individual condensed patient monitor on Multi Patient View screen
  Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
  And I should see the Hide PHI button highlighted
  And I should see the all patients name switch to displaying only the first three letters of the patient first and last name
  
  When I click the dual monitor control button in the header
  And I should see dual monitor control button is enabled in the header
  Then I should see 2 full monitors on the screen of the first 2 patients in previous screen
  And I should see the Hide PHI button highlighted
  And I should see the all patients name switch to displaying only the first three letters of the patient first and last name
  
  When I click the quad monitor control button in the header
  And I should see quad monitor control button is enabled in the header
  Then I should see 4 full monitors on the screen of the first 2 patients in previous screen
  And I should see the Hide PHI button highlighted
  And I should see the all patients name switch to displaying only the first three letters of the patient first and last name
  
  When I click the 6 view monitor control button in the header
  And I should see 6 view monitor control button is enabled in the header
  Then I should see 6 full monitors on the screen of the first 6 patients in previous screen
  And I should see the Hide PHI button highlighted
  And I should see the all patients name switch to displaying only the first three letters of the patient first and last name
  
  When I click the 9 view monitor control button in the header
  And I should see 9 view monitor control button is enabled in the header
  Then I should see 9 full monitors on the screen of the first 8 patients in previous screen
  And I should see the Hide PHI button highlighted
  And I should see the all patients name switch to displaying only the first three letters of the patient first and last name
  
  When I click the 12 view monitor control button in the header
  And I should see 12 view monitor control button is enabled in the header
  Then I should see 12 full monitors on the screen of the first 8 patients in previous screen
  And I should see the Hide PHI button highlighted
  And I should see the all patients name switch to displaying only the first three letters of the patient first and last name

  When I click the 16 view monitor control button in the header
  And I should see 16 view monitor control button is enabled in the header
  Then I should see 16 full monitors on the screen of the first 8 patients in previous screen
  And I should see the Hide PHI button highlighted
  And I should see the all patients name switch to displaying only the first three letters of the patient first and last name

  When I logout of application
  And I should see login screen
   And I am a super user with all permissions
   When I login to a testSite with a valid credential
  Then I should see the patient list screen
  # And I should see My Patients counter saved from previous session
  # When I click "My Patients" on the List
  Then I should see the patient list screen
  
  When I click the Multi-Patient View button in header 
  Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
  And I should see the Hide PHI button in header
  And I should see the Hide PHI button highlighted
  And I should see the all patients name switch to displaying only the first three letters of the patient first and last name

  When I click to "disable" the Hide PHI button
  Then I should see the Hide PHI button not highlighted
  
  