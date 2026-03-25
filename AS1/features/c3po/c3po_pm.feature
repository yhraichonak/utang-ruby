@regression @automated @c3po @pm @critical @TMS:316545
Feature: PM C3P0

  TestRail Id: C316545
  Jira Stories: MIG-248, AS1-7240
  Jira Bugs/Defects: AS1-2048, AS1-4425
  Scenario: PM C3P0 Launch - PM monitor w/no time entered
    Given I open C3PO URL generation interface
    And I open pm-mon Ascom C3PO url with payload [props.C3PO_PM_MONITOR_WITHOUT_TIME_PAYLOAD]
    Then I should see the Live Monitor screen of [props.C3PO] patient
    And I should see the Live Monitor time in "[props.COMMON_DATE_FORMAT]" format
    And the "Live" button is active
    And I should see ST parameter values
    And I should see the Docked Patient List is "active"
    When I click the "Live" button in sub navigation menu
    And the "Live" button is inactive
    And the Monitor Time Ago displays on monitor
    And I should see the Docked Patient List button is greyed out
    And I should see the Docked Event List is in live mode
    When I click the "Live" button in sub navigation menu
    And the "Live" button is active
    When I scroll the monitor waveform to the "right"

  Scenario: PM C3P0 Launch - PM monitor w/ time entered
    Given I open C3PO URL generation interface
    And I open pm-mon Ascom C3PO url with payload [props.C3PO_PM_MONITOR_WITH_TIME_PAYLOAD]
    Then I should see the Live Monitor screen of [props.C3PO] patient
    And I should see the Live Monitor at "[props.COMMON_HISTORICAL_DATE]"
    And the "Live" button is inactive
    Then I should see the Live Monitor time in "[props.COMMON_DATE_FORMAT]" format
#    And I should see that I am taken to the monitor at the specified point in time
    When I click the "Live" button in sub navigation menu
    Then I should see the "Live" button is active
    And I should see ST parameter values
    And I should see the Docked Patient List button is greyed out
    And I should see the Docked Patient List is "inactive"
#    And I should see the Docked Event List has scrolled to that point in time on the Event List(this step compares the live time with the time present in the event time)
    Then I should see the Live Monitor time display "%m/%d/%Y" format "0" days ago
    When I click the "Live" button in sub navigation menu
    Then I should see the "Live" button is inactive
    And the Monitor Time Ago displays on monitor
    When I scroll the monitor waveform to the "right"

  Scenario: PM C3P0 Launch - PM monitor with 1 day ago link
    Given I open C3PO URL generation interface
    And I generate pm-mon ascom C3PO url with query TEST=1234567890&time=[YESTERDAY.%Y-%m-%dT%H:%M:%S.%L%z]&bed=[props.C3PO_BED]&unit=[props.C3PO_UNIT]&ad=[props.C3PO_USER]
    And I navigate to the generated C3PO url
    Then I should see the Live Monitor screen of [props.C3PO] patient
    And I should see the Live Monitor time display "%m/%d/%Y" format "1" days ago
    And the "Live" button is inactive
