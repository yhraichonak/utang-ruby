@automated @TMS:40347  @cardio @cardio-edit_confirm @bvt
Feature: Confirm ECG No Order Number
  As an AS1 user
  I want be able to edit and/or confirm an ECG
  So that I can make sure a patient's ECG can not be confirmed without an order number

  TestRail Id: C40347

  Scenario: ECG Screen Order User No Order Number
    Given I am a user that can't confirm without an order number
    When I login to a testSite with a valid credential
    When I click the AS1 button
    Then I should see my ListOfList window

    When I click "Cardio Search" on the List
    Then I should see Search in the nav bar

    When I enter "[props.EC-ConfirmNoOrderNumber_LNAME]" in the cardio "Last" field
    When I enter "[props.EC-ConfirmNoOrderNumber_FNAME]" in the cardio "First" field
    And I click the search button
    When I click on "[props.EC-ConfirmNoOrderNumber_FULLNAME]" in patient list
    Then I should see the patient ECG screen

    When I click on the Edit button
    And I click the Confirm button on top of Edit/Confirm statement window
    Then The Edit and Confirm window displays with message of "Are you sure you want to confirm this ECG?"

    When I click the Alert "Yes" button on Edit/Confirm statement window
    Then The Edit and Confirm window displays with message of "Test Was Not Confirmed"
#    Then the Edit and Confirm window displays with message of "Could Not Confirm Test: In TestWorkflow.ConfirmAndPossiblyRouteForLockedMTTest  Error from MiddleTier:  "Hilltop Order Number is a required field that must contain a value.""
    When I click the alert OK button on Test Was Not Confirmed window
