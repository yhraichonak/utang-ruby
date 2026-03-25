@automated @TMS:40348  @cardio @cardio-edit_confirm @bvt
Feature: Overwrite Prompt With Minimum User Privileges
  As an AS1 user
  I want be able to edit and/or confirm an ECG
  So that I can make sure a patient's ECG displays the overwrite prompt with minimum user privileges

  TestRail Id: C40348

  Scenario: ECG Screen Overwrite Prompt With Min Priveleges
    Given I am a user with cardiac fellow permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    Then I should see my ListOfList window
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
      | diag_statement |
      | Normal sinus rhythm    |
    When I click the Confirm button on top of Edit/Confirm statement window
    Then The Edit and Confirm window displays with message of "Are you sure you want to confirm this ECG?"
    When I click the Alert "Yes" button on Edit/Confirm statement window
    Then The Edit and Confirm window displays with message of "Test Was Not Confirmed"
    When I click the alert OK button on Test Was Not Confirmed window
    Then I should see the Edit/Confirm statement window with following statements in order
      | diag_statement |
      | Normal sinus rhythm  |
