@edit_confirm_ecg @automated @TMS:40277  @cardio @cardio-edit_confirm
 Feature: Confirm By Other Means
  As an AS1 user
  So that I can make sure I receive the Confirm by Other Means message

  TestRail Id: C40277

  Scenario: Please confirm Test By Other Means
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    Then I should see my ListOfList window
    When I click "Cardio Search" on the List
    Then I should see Search in the nav bar
    When I enter "[props.EC-ConfirmOtherMeans_LNAME]" in the cardio "Last" field
    When I enter "[props.EC-ConfirmOtherMeans_FNAME]" in the cardio "First" field
    And I click the search button
    When I click on "[props.EC-ConfirmOtherMeans_FULLNAME]" in patient list
    Then I should see the patient ECG screen
    When I click on the Edit button
    Then The Edit and Confirm window displays with message of "Please Confirm Test By Other Means"
    When I click the alert OK button on Edit/Confirm window
    Then I should see the patient ECG screen
