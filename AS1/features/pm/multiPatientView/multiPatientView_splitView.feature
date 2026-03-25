@smoke @multiPatient @nodeSim @regression @automated   @pm @pm-multi_patient_view
Feature: Multi-Patient View - Split View w 2 monitors
The “SPLIT VIEW” screen will have  a 2x icon and a  4x icon.  Kory to provide icons.

The icons will display to the right of the zoomer control where “Split View” currently is

4x view will be four patients in 2x2 grid, full monitors just like split view.  

The 4x view should be able to handle 3 patients if that’s what the user had in their My patients list.

The 4x  with 3 patient view should be 3 equal sized squares with a blank bottom right.  
Note: We don’t want 1 patient being bigger than another in this view.

TestRail Id: C580274
Jira Issues: AS1-2897, AS1-2902, AS1-2906, AS1-3025, AS1-3470, AS1-3641, AS1-5720

Background:
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "My Patients" on the List
  And I have 2 or more patients added to My Patients List
  Then I should see the patient list screen
  When I click the Multi-Patient View button in header
  Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
  And I should see patients demographics, location, alarms, and 1 waveform with parameters in each condensed monitor
  And I should see default sort by Bed left to right then top to bottom
  And I should see the zoom control toggle in header
  And I should see condensed monitor control button in header
  And I should see condensed monitor control button is enabled in the header
  And I should see dual monitor control button in header
  And I should see quad monitor control button in header
  And I should see 6 view monitor control button in header
  And I should see 9 view monitor control button in header
  And I should see 12 view monitor control button in header
  And I should see 16 view monitor control button in header
 @critical @TMS:580274
Scenario: Multi-Patient View - Split View
  When I click the dual monitor control button in the header
  And I should see dual monitor control button is enabled in the header
  Then I should see 2 full monitors on the screen of the first 2 patients in previous screen
  And I should see the 2 full monitors should split the screen in half
#  And waveforms are streaming in both monitors (AS1-5720)
  And I should see Patient Name Last, First, Age Gender, Unit, Bed on first row for each monitor
  And I should see Navigation bar with Select Time and Live for each monitor
  
  When I click the condensed monitor control button in the header
  And I should see condensed monitor control button is enabled in the header
  Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
  
  When I click the Home icon
  Then I should see the patient list screen
  And I should be on "My Patient" patientList
