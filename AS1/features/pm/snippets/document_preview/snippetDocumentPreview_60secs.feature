@regression @doc_preview @automated @core @pm @pm-snippets @pm-snippets-document_preview @TMS:264395
Feature: PM - Snippet Document Preview Layout - 60 seconds

  TestRail Id: C264395
  Jira Stories: AS1-161, AS1-622
  Jira Bugs/Defects: AS1-6800, AS1-7038

  @critical
  Scenario: PM - Snippet Document Preview Layout - 60 seconds
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

    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"

    When I select "60 seconds" in option dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG1]" waveform and "[props.COMMON_ECG2]" waveform in chart and rhythm strip on Snippet screen

    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    And I should see a messaging loading bar for snippets data selected in future
    And I should see the All Leads, Preview, OK buttons disabled until page loads
    When I click the Preview button on Snippet Document Edit View
    Then I should see the Snippet Document Preview window
    When I scroll the Snippet Preview Document "right"
    Then I should see the Snippet Document Preview window
    When I scroll the Snippet Preview Document "right"
    Then I should see the Snippet Document Preview window

    When I scroll the Snippet Preview Document "left"
    Then I should see the Snippet Document Preview window
    When I scroll the Snippet Preview Document "left"
    Then I should see the Snippet Document Preview window

    When I scroll the Snippet Preview Document "down"
    Then I should see the Snippet Document Preview window
    When I scroll the Snippet Preview Document "right"
    Then I should see the Snippet Document Preview window
    When I scroll the Snippet Preview Document "right"
    Then I should see the Snippet Document Preview window

    When I scroll the Snippet Preview Document "left"
    Then I should see the Snippet Document Preview window
    When I scroll the Snippet Preview Document "left"
    Then I should see the Snippet Document Preview window

    When I scroll the Snippet Preview Document "down"
    Then I should see the Snippet Document Preview window
    When I scroll the Snippet Preview Document "down"
    Then I should see the Snippet Document Preview window
    When I scroll the Snippet Preview Document "right"
    When I scroll the Snippet Preview Document "right"
    Then I should see the Snippet Document Preview window

  Scenario: PM - Snippet Document Preview Layout - All Leads On 60 secs
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    When I select "60 seconds" in option dropdown on Snippet screen
    And I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I click the All Leads button "On"
    And I click the Preview button on Snippet Document Edit View
    Then I should see the Snippet Document Preview window
    And  I scroll the Snippet Preview Document "down"
    And I click the Save button on Snippet Document Preview screen
    Then I see Snippet Saved notification window
    And I click OK button Snippet Saved notification window
    When I click the "[props.COMMON_SITE_NAME]" button in the main header
    And I click "Snippets Report" on the List
    And Select all units at Supervisor Snippet Report screen
    And I clear Bed search "From" textfield on Supervisor Snippet Report Screen
    And I clear Bed search "To" textfield on Supervisor Snippet Report Screen
    And I click search button to retrieve reports
    And I click View button on the same patient
    And I see the snippet appear in viewer window
    And I see a OK button in snippet viewer window
    And I click the OK button in snippet viewer window
