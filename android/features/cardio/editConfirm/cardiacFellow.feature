@automated @TMS:581594  @cardio @cardio-edit_confirm @regression @bvt
Feature: Edit Confirm - Confirm ECG (cardiac fellow muse role)
  As a AS1 user with cardiac fellow muse role
  I should receive a status mismatch message when I try to reconfirm Ecg in AS1

  TestRail Id: C581594

  Scenario: Edit and Confirm an ECG as Cardiac Fellow MuseRole
    Given I am a user with cardiac fellow permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "Cardio Search" on the List
    Then I should see Search in the nav bar
    When I enter "[props.EC-CardiacFellow_LNAME]" in the cardio "Last" field
    When I enter "[props.EC-CardiacFellow_FNAME]" in the cardio "First" field
    And I click the search button
    When I click on "[props.EC-CardiacFellow_FULLNAME]" in patient list
    Then I should see the patient ECG screen

    When I click on the Edit button
    Then The Edit and Confirm window displays with a message including "This test was already confirmed by"
    When I click the alert continue button on Edit/Confirm window
    Then I should see the Edit/Confirm screen

    When I click the Confirm button on top of Edit/Confirm statement window
    Then The Edit and Confirm window displays with message of "Are you sure you want to confirm this ECG?"
    When I click the Alert "Yes" button on Edit/Confirm statement window
    Then The Edit and Confirm window displays with message of "Test Was Not Confirmed"
    When I click the alert OK button on Test Was Not Confirmed window
    Then I should see the Edit/Confirm screen

#    Note: The "Yes" button on the "Are you sure?" prompt window cannot be found and therefore cannot be
#    clicked even through an appium tap
