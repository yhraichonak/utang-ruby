@regression @doc_preview @manual @automated @pre_backup_server_config @post_restore_server_config @edit_server_config

Feature: PM - Snippet Document Edit - All Leads Config On

  Due to AS1-4841, the configuration set to "ON" needs to be tested for the purpose of functionality within application
  Per AS1-7021, The configuration of "AllLeadsDefault" is NOT expected to result in effecting the behavior of the
  "All Leads" Toggle, as Sticky Setting is prioritized over Config (stickySetting > "allLeadsDefault")
  -Sticky Setting should retain within session and between sessions as long as local storage cache has user settings saved
  -If Local storage cache is cleared, this should result in configuration set to "True" is being used, however this
  will not effect the appearance of the "All Leads" toggle

  TestRail Id: C316521

  Jira Stories: AS1-866

  Jira Bugs/Defects: AS1-2641, AS1-4841, AS1-7021

  Scenario: PM - Snippet Document Edit - All Leads Config "ON"
    Given User restores test environment config.json file from "AS1/wc_316521_config.json"
    And restart WebClient service
    And clear browser cache and reload
    And I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    And I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    When I click on Measure button
    Then I should see the Measure button "active"
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I click the All Leads button "Off"
    Then the All Leads toggle is switched "Off"
    When I click the Save button on Snippet Document Edit screen
    Then I see Snippet Saved notification window
    When I click OK button Snippet Saved notification window
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    And I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    And the All Leads toggle is switched "Off"
    And I click the username dropdown indicator
    Then I should see About and Logout links
    When I click on Logout link
    Then I should see the login screen
    And I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    And I select "[props.COMMON_ECG1]" waveform in option 1 dropdown on Snippet screen
    And I select "[props.COMMON_ECG2]" waveform in option 2 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG1]" waveform and "[props.COMMON_ECG2]" waveform in chart and rhythm strip on Snippet screen
    When I click on Measure button
    Then I should see the Measure button "active"
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    And the All Leads toggle is switched "Off"
    When I click the All Leads button "On"
    Then the All Leads toggle is switched "On"
    When I click the Save button on Snippet Document Edit screen
    Then I see Snippet Saved notification window
    When I click OK button Snippet Saved notification window
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    And I select "[props.COMMON_ECG1]" waveform in option 1 dropdown on Snippet screen
    And I select "[props.COMMON_ECG2]" waveform in option 2 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG1]" waveform and "[props.COMMON_ECG2]" waveform in chart and rhythm strip on Snippet screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    And the All Leads toggle is switched "On"
    And I click the username dropdown indicator
    Then I should see About and Logout links
    When I click on Logout link
    Then I should see the login screen
    And I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    And I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    And the All Leads toggle is switched "On"