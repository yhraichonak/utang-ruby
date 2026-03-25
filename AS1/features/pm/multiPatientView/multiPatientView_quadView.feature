@smoke @multiPatient @nodeSim @regression @automated   @pm @pm-multi_patient_view
Feature: Multi-Patient View - Quad View
Quad View
The Quad View screen displays 4 patients - the screen is split into 4 equal quadrants (50/50 vertical & 50/50 horizontal)

Header:
The header includes Group/Sort, Filter Units (grayed out), Multi-Patient View(right aligned)
Zoom Control, (Split Screen buttons to be provided by Kory) 2x button and a 4x button, Search (left aligned)

*Patient Cell+
1st row:
Patient Name (Last, First, Age*Gender)
Unit*Bed 

2nd row:
Navigation bar with Select Time and Live

3rd row: Waveform space
Leads 
Waveform needs to retain consistent horizontal scale
Reference precedence order of waveforms in Jira  AS1-2506: Snippets Waveform Analysis ToolOPEN OPEN (configuration story)

Parameters listed vertically  from PM space – Reference discretes priority logic  AS1-2498: PM Monitor ViewOPEN OPEN
Follow same precedence order from PM Reference Jira  AS1-2498: PM Monitor ViewOPEN OPEN

Navigation
From Multi-Patient View screen (full mode), when a user clicks on 4x button from the header, the Split Screen view displays with the screen split vertically.
The user selects Split Screen from the header to close this mode.
or
The user selects home screen to close.

Tapping a discrete opens trends

TestRail Id: C580275
Jira Issues: AS1-2942, AS1-3025, AS1-3011, AS1-5720

Background:
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "My Patients" on the List
  And I have 4 or more patients added to My Patients List
  Then I should see the patient list screen
  When I click the Multi-Patient View button in header
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
 @critical @TMS:580275
Scenario: Multi-Patient View - Quad View
  When I click the quad monitor control button in the header
  And I should see quad monitor control button is enabled in the header
  Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
  And I should see the 4 full monitors should split the screen half vertical half horizontal
#  And waveforms are streaming in all four monitors (AS1-5720)
  And I should see Patient Name Last, First, Age Gender, Unit, Bed on first row for each monitor
  And I should see Navigation bar with Select Time and Live for each monitor 
  
  When I click the condensed monitor control button in the header
  And I should see condensed monitor control button is enabled in the header
  Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
  
  When I click the Home icon
  Then I should see the patient list screen
  And I should be on "My Patient" patientList
