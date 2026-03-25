@vents @automated @core @pm @pm-vents @pm-vents-summary
Feature: PM - Vents - Ventilator Tile


TestRail Id: C264391
Jira Stories: AS1-
@obsolete
Scenario: PM - Vents - Ventilator Tile
  Given I login to simulator with "username" and "XXXXX"
	Then I should see the patient list screen
  When I click "Ventilator" on the List
  Then I should see the patient list screen
	When I click on "Russell, George" in PM patient list
  Then I should see the patient summary screen
  And I should see Ventilator tile
  And I should see the following info in Ventilator tile
  | RR     | Ex_Vt  | Ex_Ve     | PIP       | Peep    | Peep_Total |
  | 22 bpm | 635 mL | 14.08 lpm | 31 cm H2O | 5 L/min | 7 cm H20   |
