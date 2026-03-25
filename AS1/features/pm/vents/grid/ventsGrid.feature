@vents @automated @core @pm @pm-vents @pm-vents-grid
Feature: PM - Vents - Grid

TestRail Id: C582414
Jira Stories: AS1-275
 @obsolete
Scenario: PM - Vents - Grid
  Given I login to simulator with "username" and "XXXXX"
	Then I should see the patient list screen
  When I click "Ventilator" on the List
  Then I should see the patient list screen
	When I click on "Russell, George" in PM patient list
  Then I should see the patient summary screen
  When I click on the Ventilator tile
  Then I should see the Ventilator Grid screen

  When I scroll the ventilator grid to the "right"

  When I scroll the ventilator grid to the "right"

  When I scroll the ventilator grid to the "left"

  When I scroll the ventilator grid to the "left"

  When I scroll the ventilator grid to the "down"

  When I scroll the ventilator grid to the "down"

  When I scroll the ventilator grid to the "up"

  When I scroll the ventilator grid to the "up"
