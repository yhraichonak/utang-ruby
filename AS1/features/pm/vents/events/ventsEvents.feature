@vents @automated @core @pm @pm-vents @pm-vents-events
Feature: PM - Vents - Events
*+Requirements+*
__________________________________________________________________________________
User can view event details for a given patient. Details may include:
 - Time
 - Date
 - Name
 - Severity
(VEN-EVT01)

 - Events screen displays up to 72 hours of vents events
 - Events display in in reverse chronological order (most recent at the top).
 - Events times display in military time to include seconds.
 - Events display event date, time, type and status


TestRail Id: C264389
Jira Stories: AS1-337
@obsolete
Scenario: PM - Vents - Events
  Given I login to simulator with "username" and "XXXXX"
	Then I should see the patient list screen
  When I click "Ventilator" on the List
  Then I should see the patient list screen
	When I click on "Russell, George" in PM patient list
  Then I should see the patient summary screen
  When I click on the Ventilator tile
  Then I should see the Ventilator Grid screen
  When I click the "Events" button in vents navigation menu
  Then I should see the Ventilator Events screen


