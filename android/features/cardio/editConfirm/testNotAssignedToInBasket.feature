@automated @TMS:40283  @cardio @cardio-edit_confirm @bvt
Feature: View the Test Not Assigned to Inbasket Message
  As an AS1 user
  I want be able view the Test Not Assigned to Inbasket Message

  TestRail Id: C40283

  Scenario: Test Not Assigned to Inbasket
    Given I am a user that can't confirm out of InBasket
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "Cardio Search" on the List
    Then I should see Search in the nav bar
    When I enter "[props.EC-TestNotAssigned_LNAME]" in the cardio "Last" field
    When I enter "[props.EC-TestNotAssigned_FNAME]" in the cardio "First" field
    And I click the search button
    When I click on "[props.EC-TestNotAssigned_FULLNAME]" in patient list
    Then I should see the patient ECG screen
    When I click on the Edit button
    Then The Edit and Confirm window displays with message of "Test Is Not Assigned To Your InBasket"
    When I click the alert OK button on Edit/Confirm window
    Then I should see the patient ECG screen
