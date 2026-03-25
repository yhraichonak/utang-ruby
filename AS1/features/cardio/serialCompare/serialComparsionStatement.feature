@regression @serialCompare @automated @core@cardio @cardio-serial_compare
Feature: Serial Compare - Comparison Statement Logic
  As a user I want to be notified when I am viewing a comparison statement for ECGs that are not related to the text of
  that comparison statement so that I avoid confusion.

From a perspective of Clinical workflow the app should warn users when they are getting into a situation where they are
comparing 2 ECGs while there is a Comparison statement present not related to both ECGs. e.g. If the patient had ECGs
A, B, C with A being the oldest ECG and C being the most recent; and there was a Comparison statement associated with
C as it related to B.

The system should be aware of when a Serial Comparison is being triggered. When 2 ECGs are being compared where the
Comparison Statement on one of the ECGs does not pertain to the other ECG selected, then the client UI will present a
notification in the Overlay just before the Diagnostic Statement.

Text to display prior to the Diagnostic Statement which is below the measurements and will include label styling. Will
only display when the server sends you the 'testsRelated=false' flag on the most recent ECG.

" *NOTE: The comparison statement displayed does not match the ECGs you have selected for comparison. "
  
TestRail Id: C264301
Jira Issues: AS1-547
@critical @TMS:264301
Scenario: Serial Compare - Comparison Statement Logic
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "MOST RECENT" on the List
  Then I should see the patient list screen
  When I click on "Nesbitt, Esron" in patient list
  Then I should see the patient summary screen
  When I click on the ECG tile
  Then I should see the ecg list on ECG screen
  When I click on row "1" on ecg list
  Then I should see the patient ECG screen
  And I should see the compare link enabled
  When I click the Compare link
  Then I should see the second ecg list on the ECG screen
  When I click on row "2" on the second ecg list
  Then I should see the Serial Compare screen
  And I should see patient info in ecg screen header
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead
  Then I should see the serial compare 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead in serial compare ecg
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead in serial compare ecg
  And I should see the following Comparison Statement "*NOTE: The comparison statement displayed does not match the ECGs you have selected for comparison."
  
  