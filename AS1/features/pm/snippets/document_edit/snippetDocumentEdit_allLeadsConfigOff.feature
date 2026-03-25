@regression @doc_preview @automated @core @pm @pm-snippets @pm-snippets-document_edit
Feature: PM - Snippet Document Edit - All Leads Config Off

All leads toggle currently has a persistence within a session, where it retains ON or OFF within that session

Default status (ON or OFF) of the toggle should be configurable by unit.Scenario 1:
(Where Units A, C, and ICU exist. A, and C are default OFF and ICU is Default ON)
On first login:

User takes Snippet on patient in Unit A
All leads toggle is Off
User turns toggle ON
User takes Snippet on Patient in Unit C
All leads toggle is ON (because of persistence setting)
User turns toggle OFF
User takes snippet on patient in Unit ICU
All leads toggle is OFF (because of persistence setting)
After Logout/re-login:
*
User takes Snippet on patient in Unit A
All leads toggle is Off
User takes Snippet on Patient in Unit C
All leads toggle is OFF
User takes snippet on patient in Unit ICU
All leads toggle is ON (because of default setting)
*need to determine if persistence within session can be retained and verify if default>persistence or persistence>default

---------------------------------------------------------------------------------------------------------
PLEASE NOTE: ex. the config-develop.json needs to have following configuration in it:
"pm": {
    "allLeadsDefault": false
}
---------------------------------------------------------------------------------------------------------

TestRail Id: C316520
Jira Stories: AS1-866
@critical @TMS:316520
Scenario: PM - Snippet Document Edit - All Leads Config Off
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen

  When I click on default patient in list without redirect
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen

  When I click on Measure button
  Then I should see the Measure button "active"
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View

  And the All Leads toggle is switched "Off"
  When I click the All Leads button "On"
  Then the All Leads toggle is switched "On"

  When I click the Save button on Snippet Document Edit View
  Then I see Snippet Saved notification window
  When I click OK button Snippet Saved notification window
  Then I should see the Live Monitor screen

  When I click the "Tools" button in sub navigation menu
  And I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And the All Leads toggle is switched "On"

  When I logout of application
  And I should see login screen
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen

  When I click on default patient in list without redirect
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  When I click on Measure button
  Then I should see the Measure button "active"
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And the All Leads toggle is switched "On"

  When I click the All Leads button "Off"
  Then the All Leads toggle is switched "Off"
  When I click the Save button on Snippet Document Edit View
  Then I see Snippet Saved notification window
  When I click OK button Snippet Saved notification window
  Then I should see the Live Monitor screen

  When I click the "Tools" button in sub navigation menu
  And I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And the All Leads toggle is switched "Off"

  When I logout of application
  And I should see login screen
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click on default patient in list without redirect
  Then I should see the Live Monitor screen

  When I click the "Tools" button in sub navigation menu
  And I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And the All Leads toggle is switched "Off"
