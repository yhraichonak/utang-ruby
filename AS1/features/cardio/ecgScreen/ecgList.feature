@regression @automated @core @cardio @cardio-ecg_screen @critical @TMS:179306
Feature: ECG Screen - ECG List

TestRail Id: C179306

JIRA Epic: AS1-27, AS1-2560

JIRA Stories: AS1-35, AS1-72, AS1-6634

JIRA Bugs/defects:

Scenario: ECG List
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "MOST RECENT" on the List
  Then I should see the patient list screen
  When I click on "[props.DP_FULL_NAME]" in patient list
  When I click on the ECG tile
  Then I should see the ecg list on ECG screen

  When I click on row "1" on ecg list
  Then I should see the patient ECG screen
  When I click on the info icon on the ecg toolbar
  Then the ecg detailed info drawer displays
  When I click on the info icon on the ecg toolbar
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  
  When I click on the ecg list button on the ecg toolbar
  Then the ecg option list displays
  When I click on row "2" on ecg list
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  When I click on the info icon on the ecg toolbar
  Then the ecg detailed info drawer displays
