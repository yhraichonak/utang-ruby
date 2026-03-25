@smoke @multiPatient @regression @automated@pm @pm-multi_patient_view
Feature: Multi-Patient View - 16 View
8 View
Header:
The header includes Group/Sort, Filter Units, Multi-Patient View(left aligned)
Zoom Control (Single lead only) Condensed PM Box Control (single lead only), Split Screen View Control, Quad View Control, 6 view control, 8 view control, search (right aligned)

Patient Cell
1st row:
Patient Name (Last, First, Age*Gender)
Unit*Bed 

2nd row:

Monitor space
Leads 
Waveform needs to retain consistent horizontal scale
Show 8 patient monitors, 4 rows of 2 monitors each (equally sized)
Reference precedence order of waveforms in Jira  AS1-2506: Snippets Waveform Analysis ToolOPEN OPEN (configuration story)

Monitors in MPV
The Monitor area in 8 view mode will display in a similar fashion to PM, aside from anything referenced as different in this storynitor area in  6 View mode will display in a similar fashion to PM, aside from anything referenced as different in this story


AS1-3953-
-Remove the "Select Time | Live" header/navigation row for all non-focused monitor views above 4, including:
6 view 
9 view 
12 view
16 view 

AS1-3955
  MPV - Display 6+ views in rows of 3 by default (Web)
    All views above 4 should display by default in rows of 3.  
      16 view should be 4 rows of 4 monitors each 
    When not enough patients selected to fill the screen (e.g. 5 patients on 6 view) extra monitor space(s) should NOT fill. 
    Note: This is the default display but may be affected by the zoom level set by the user. 

TestRail Id: C581580

Jira Epic: AS1-2809

Jira Stories: AS1-3469, AS1-3470, AS1-3953, AS1-3955, AS1-5720
  
Jira Bugs/Defects:

Background:
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  And reset unit filtering
  And I clear grouping on patients list
  When I click "My Patients" on the List
  And I have 16 or more patients added to My Patients List
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
@critical @TMS:581580
Scenario: Multi-Patient View - 16 View
  When I click the 16 view monitor control button in the header
  And I should see 16 view monitor control button is enabled in the header
  Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
  And I should see the 16 full monitors should split into 4 rows and 4 monitors on each row
#  And waveforms are streaming in all 16 monitors (AS1-5720)
  And I should see Patient Name Last, First, Age Gender, Unit, Bed on first row for each monitor

  #And I should not see the Select Time and Live buttons on the Navigation bar on any patients monitor
  
  When I click the condensed monitor control button in the header
  And I should see condensed monitor control button is enabled in the header
  Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
  
  When I click the Home icon
  Then I should see the patient list screen
  And I should be on "My Patient" patientList
