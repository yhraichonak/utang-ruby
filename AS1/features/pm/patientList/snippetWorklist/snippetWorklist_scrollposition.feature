@manual @automated @core @pm @pm-patient_list @pm-patient_list-snippet_worklist
Feature: Patient List - Snippet Worklist Layout


TestRail Id: C581756
Jira Stories: AS1-3863
  @TMS:581756
Scenario: Snippet Worklist Scrolling
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
	Then I should see the patient list screen
  When I click "Snippet Worklist" on the List
  Then I should see the snippet worklist screen
  When I toggle hide completed snippets on
  And I scroll to the bottom of the snippet worklist
  And I select the bottom patient
  Then I should see the Snippet Tool screen
  When I click the back button in the Snippet Tools Header
  Then I should see the snippet worklist screen
  And I should see the bottom of the worklist
  When I select the bottom patient
  Then I should see the Snippet Tool screen
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  When I click the Save button on Snippet Document Edit screen
  Then I see Snippet Saved notification window
  When I click OK button Snippet Saved notification window
  Then I should see the snippet worklist screen
  And I should see the bottom of the worklist
