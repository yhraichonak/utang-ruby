@automated @TMS:40282  @cardio @cardio-edit_confirm @bvt
Feature: View the Status Mismatch Message
  As an AS1 user
  I want be able view the Status Mismatch Message

  TestRail Id: C40282

  Scenario: Status Mismatch - Test information out of date
    Given I am a user with cardiac fellow permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "Cardio Search" on the List
    Then I should see Search in the nav bar
    When I enter "[props.EC-StatusMismatch_LNAME]" in the cardio "Last" field
    When I enter "[props.EC-StatusMismatch_FNAME]" in the cardio "First" field
    And I click the search button
    When I click on "[props.EC-StatusMismatch_FULLNAME]" in patient list
    Then I should see the patient ECG screen
    When I click on the Edit button
    Then The Edit and Confirm window displays with message of "The information for this test is out of date. Unable to Edit/Confirm at this time."
    When I click the alert OK button on Edit/Confirm window
    Then I should see the patient ECG screen
