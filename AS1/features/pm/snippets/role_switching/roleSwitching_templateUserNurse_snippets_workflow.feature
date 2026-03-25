@automated @core @automated @pre_backup_server_config @post_restore_server_config @edit_server_config
Feature: roleSwitching_templateUserNurse_snippets_workflow
  As an utang ONE user
  I need to set Nurse and Monitor Tech templates
  So that I can confirm Nurse role switching workflows

  AS1-5798, AS1-5797
  **Note 1 - this is a first implementation of Role Selection for Snippet workflow and is working with the constraint
  of only one Template User.
  **Note 2 - for a customer configuration to be compatible with this feature a customer must be using Snippets AND ONLY
  the Nurse Users can be associated with the Template User. If any other user types are also using the Template User,
  this configuration option is not compatible.
  Create a configuration that, when enabled/true, will modify the AS1 app behavior of a Template User with Snippets workflow.
  AS1 app behavior change:
  If user chooses the "Nurse" option - behave as normal (no Snippets approval required, display worklists associate with
  Nurses/Template user
  Append "Nurse" role to end of username (e.g. user1 - Nurse)
  If user chooses the "Monitor Tech" option - Snippets will require approval, display worklists associated with Monitor
  Techs Append "Monitor Tech" role to end of username (e.g. user1 - Monitor Tech) Show/Hide Role Switch Selection
  User from the single AD group associated with Template User successfully logs into the Site/App
  If Server-side configuration is enabled/true
  then Role Switch will be a selection in Preferences
  If server-side configuration is disabled/false
  then Role Switch will not be a selection in Preferences

  Example (Where nurse is not configured for worklists):
  Nurse Monitor Tech
  Configured for worklists No Yes
  Requires approval No Yes
  AD Group Association Template User None (i.e. not Template User)

  Nurse 1:
  Nurse 1, when selecting "Preferences"
  Nurse 1 - chooses "Nurse"
  Will not see worklists
  Created snippets will not require approval
  Nurse 1 - chooses "Monitor Tech"
  Will see worklists associated with Monitor Tech
  Created snippets will require approval

  Monitor Tech 1:
  Monitor Tech, when selecting "Preferences"
  Will not see role selector
  Will not see role appended to username
  Monitor Tech will see worklists
  Created snippets will require approval

  TestRail Id: C582877

  Jira Epic: AS1-5800
  Jira Stories: AS1-5797, AS1-5798,
  Jira Bugs/Defects: AS1-7052

  Scenario: Single Template User - Nurse applications - Worklists turned on
    Given User restores test environment config.json file from "AS1/wc_582877_config.json"
    And restart WebClient service
    And clear browser cache and reload
    And I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    And I should see - Nurse following the username
    When I click the username dropdown indicator
    Then I should see the options About, Preferences and Logout
    When I click the Preferences button
    Then I should see the Preferences window
    And I should "see" the Role: section
    And I should see the Role listed as Nurse
    And I click on Done button on the Preferences screen
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    When I click the Create Snippet button
    When I click the Save button on Snippet Document Edit screen
    Then I see Snippet Saved notification window
    When I click OK button Snippet Saved notification window
    Then I should see the Live Monitor screen
    When I click the Back button in patient header
    Then I should see the patient list screen
    When I click "Snippets Report" on the List
    Then I should see the Supervisor Snippet Report screen
    And I should see the "Patient Name" present in the supervisor report
    And I click View button on the same patient
    And I see the snippet appear in viewer window
    And I see a OK button in snippet viewer window
    And I click the OK button in snippet viewer window
    Then I should see the Supervisor Snippet Report screen
    When I click the Home icon
    Then I should see the patient list screen
    And I click "Census" on the List
    Then I should see the patient list screen
    When I click the username dropdown indicator
    Then I should see the options About, Preferences and Logout
    When I click the Preferences button
    Then I should see the Preferences window
    And I should "see" the Role: section
    And I see a dropdown menu and select role type as "Monitor Tech"
    Then I should see the patient list screen
    And I should see - Monitor Tech following the username
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    When I click the Create Snippet button
    When I click the Save button on Snippet Document Edit screen
    Then I see Snippet Saved notification window
    When I click OK button Snippet Saved notification window
    Then I should see the Live Monitor screen
    When I click the Back button in patient header
    Then I should see the patient list screen
    When I click "Snippets Report" on the List
    Then I should see the Supervisor Snippet Report screen
    And I should see the "Patient Name" present in the supervisor report
    And I click View button on the same patient
    And I see the snippet appear in viewer window
    And I see a OK button in snippet viewer window
    And I click the OK button in snippet viewer window
    Then I should see the Supervisor Snippet Report screen
    When I click the Home icon
    Then I should see the patient list screen
    And I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Overview" link in main navigation menu
    Then I should see the patient summary screen
    When I click the "Documents" link in main navigation menu
    Then I click on the Unapproved icon for latest snippet document
    And I should see the document item "1" selected
    And the document should appear in viewer
    And I should see not the Approve and Reject buttons in list for selected document

  Scenario: Single Template User - Nurse applications - Worklists turned off
    Given User restores test environment config.json file from "AS1/wc_582877_config.json"
    And restart WebClient service
    And clear browser cache and reload
    Given I login to a testSite with "super-all-role1" and "XXXXXXXXXX"
    And I should see - Nurse following the username
    When I click the username dropdown indicator
    Then I should see the options About, Preferences and Logout
    When I click the Preferences button
    Then I should see the Preferences window
    And I should "see" the Role: section
    And I should see the Role listed as Nurse
    And I click on Done button on the Preferences screen
    Then I should see the patient list screen
    Then I should not see "Snippet Worklist" in the sidebar
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    When I click the Create Snippet button
    When I click the Save button on Snippet Document Edit screen
    Then I see Snippet Saved notification window
    When I click OK button Snippet Saved notification window
    Then I should see the Live Monitor screen
    When I click the Back button in patient header
    Then I should see the patient list screen
    When I click "Snippets Report" on the List
    Then I should see the Supervisor Snippet Report screen
    And I should see the "Patient Name" present in the supervisor report
    And I click View button on the same patient
    And I see the snippet appear in viewer window
    And I see a OK button in snippet viewer window
    And I click the OK button in snippet viewer window
    Then I should see the Supervisor Snippet Report screen
    When I click the Home icon
    Then I should see the patient list screen
    And I click "Census" on the List
    Then I should see the patient list screen
    When I click the username dropdown indicator
    Then I should see the options About, Preferences and Logout
    When I click the Preferences button
    Then I should see the Preferences window
    And I should "see" the Role: section
    And I see a dropdown menu and select role type as "Monitor Tech"
    Then I should see the patient list screen
    And I should see - Monitor Tech following the username
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    When I click the Create Snippet button
    When I click the Save button on Snippet Document Edit screen
    Then I see Snippet Saved notification window
    When I click OK button Snippet Saved notification window
    Then I should see the Live Monitor screen
    When I click the Back button in patient header
    Then I should see the patient list screen
    When I click "Snippets Report" on the List
    Then I should see the Supervisor Snippet Report screen
    And I should see the "Patient Name" present in the supervisor report
    And I click View button on the same patient
    And I see the snippet appear in viewer window
    And I see a OK button in snippet viewer window
    And I click the OK button in snippet viewer window
    Then I should see the Supervisor Snippet Report screen
    When I click the Home icon
    Then I should see the patient list screen
    And I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Overview" link in main navigation menu
    Then I should see the patient summary screen
    When I click the "Documents" link in main navigation menu
    Then I click on the Unapproved icon for latest snippet document
    And I should see the document item "1" selected
    And the document should appear in viewer
    And I should see not the Approve and Reject buttons in list for selected document

  Scenario: Single Template User - Monitor Tech applications in AMP
    Given User restores test environment config.json file from "AS1/wc_582877_config.json"
    And restart WebClient service
    And clear browser cache and reload
    Given I login to a testSite with "super-all-role2" and "XXXXXXXXXX"
    Then I should see only the username
    When I click the username dropdown indicator
    Then I should see the options About, Preferences and Logout
    When I click the Preferences button
    Then I should see the Preferences window
    And I should "not see" the Role: section
    And I click on Done button on the Preferences screen
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    When I click the Create Snippet button
    When I click the Save button on Snippet Document Edit screen
    Then I see Snippet Saved notification window
    When I click OK button Snippet Saved notification window
    Then I should see the Live Monitor screen
    When I click the Back button in patient header
    Then I should see the patient list screen
    When I click "Snippets Report" on the List
    Then I should see the Supervisor Snippet Report screen
    And I should see the "Patient Name" present in the supervisor report
    And I click View button on the same patient
    And I see the snippet appear in viewer window
    And I see a OK button in snippet viewer window
    And I click the OK button in snippet viewer window
    Then I should see the Supervisor Snippet Report screen
    When I click the Home icon
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Overview" link in main navigation menu
    Then I should see the patient summary screen
    When I click the "Documents" link in main navigation menu
    Then I click on the Unapproved icon for latest snippet document
    And I should see the document item "1" selected
    And the document should appear in viewer
    And I should see not the Approve and Reject buttons in list for selected document

  Scenario: Template User settings turned off
    Given User restores test environment config.json file from "AS1/wc_582877_config_off.json"
    And restart WebClient service
    And clear browser cache and reload
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    Then I should see my username with no role listed
    When I click the username dropdown indicator
    Then I should see the options About, Preferences and Logout
    When I click the Preferences button
    Then I should see the Preferences window
    And I should "not see" the Role: section
    And I click on Done button on the Preferences screen
    And I should see the patient list screen
