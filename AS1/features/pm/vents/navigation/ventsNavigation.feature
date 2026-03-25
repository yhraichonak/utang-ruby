@vents @automated @core @pm @pm-vents @pm-vents-navigation
Feature: PM - Vents - Navigation
Requirements
___________________________________________________________
User can access realtime Ventilator data (i.e. measurements, settings, and events) as well as Laboratory data over a defined time period for a given patient. (VEN-NAV01)

From the Navigation List:

Choose VENTILATOR in the PATIENT MONITORING section.
From the Patient Summary Screen:

Select the Ventilator tile
Select the Vents button (web only)
The user can return to previous navigational context from Patient Summary screen
Vents Screen
Readings/Chicklets/Discreets and Trends

Select a reading/discrete/chicklet, the trend for that reading displays
Deselect a reading/discrete/chicklet, the trend hides
Select a setting with multiple values (number of values in parenthesis in bottom right corner of the cell) all values display.
Deselect a setting with multiple values (number of values in parenthesis in bottom right corner of the cell) all values hide.
Select a lab with a multiple or corrected values (represented by a note icon in the right corner of the cell), labs details screen/pop-up displays.
(iOS Phone Only) Select the overflow button
(iOS) - Share, Events, Refresh options display.
(Android) - Events, Share, Logout, Settings, About options display
Select the Refresh button (overflow in iOS, button in Android), the Vents screen refreshes.
Select the Events button (in share menu for iOS phone, bell icon iOS tablet), Vents Events screen displays.
Select the Grid button (top right corner), the trends screen displays.
Double tap (iOS) Single tap (Android) the settings/labs column, column expands to display all label text.
Double tap (iOS) Single tap (Android) again the settings/labs column, collapses (a little, not completely - reverts back to default size)
The user can return to previous navigational context from Vents screen

TestRail Id: C264390
Jira Stories: AS1-273
 @obsolete
Scenario: PM - Vents - Navigation
  Given I login to simulator with "username" and "XXXXX"
	Then I should see the patient list screen
  When I click "Ventilator" on the List
  Then I should see the patient list screen
	When I click on "Russell, George" in PM patient list
  Then I should see the patient summary screen
  When I click on the Ventilator tile
  Then I should see the Ventilator Grid screen
  When I click the "Graphs" button in vents navigation menu
  Then I should see the Ventilator Graphs screen
  When I click the "Events" button in vents navigation menu
  Then I should see the Ventilator Events screen
  When I click the "Grid" button in vents navigation menu
  Then I should see the Ventilator Grid screen
  When I click the Back button in PM patient header
  Then I should see the patient list screen
  When I click on "Russell, George" in PM patient list
  Then I should see the patient summary screen
  When I click the "Vents" link in main navigation menu
  Then I should see the Ventilator Grid screen

