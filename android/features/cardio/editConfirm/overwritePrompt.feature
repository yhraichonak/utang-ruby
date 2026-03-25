@automated @TMS:40280  @cardio @cardio-edit_confirm @bvt
Feature: View the Overwrite Prompt Message
  As an AS1 user
  I want be able view the Overwrite Prompt Message

  TestRail Id: C40280

  Scenario: Overwrite Prompt - Test already confirmed
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "Cardio Search" on the List
    Then I should see Search in the nav bar
    When I enter "[props.EC-ConfirmECG_LNAME]" in the cardio "Last" field
    When I enter "[props.EC-ConfirmECG_FNAME]" in the cardio "First" field
    And I click the search button
    When I click on "[props.EC-ConfirmECG_FULLNAME]" in patient list
    Then I should see the patient ECG screen
    When I click on the Edit button
    Then The Edit and Confirm window displays with a message including "This test was already confirmed by"
    When I click the alert continue button on Edit/Confirm window
    Then I should see the Edit/Confirm statement window with following statements in order
      | diag_statement     		                           |
      | Normal sinus rhythm |
    When I click the Confirm button on top of Edit/Confirm statement window
    Then The Edit and Confirm window displays with message of "Are you sure you want to confirm this ECG?"
    When I click the Alert "Yes" button on Edit/Confirm statement window
    Then The Edit and Confirm window displays with message of "Test Has Been Updated"
    When I click the alert OK button on Saving Statements window
    Then I should see the patient ECG screen
