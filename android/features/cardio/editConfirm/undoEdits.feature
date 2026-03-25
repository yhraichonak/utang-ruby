@automated @TMS:40284  @cardio @cardio-edit_confirm @bvt
Feature: Undo Edits
  As an AS1 user
  I want be able to undo edits on an ECG

  TestRail Id: C40284

  Scenario: Undo Edits on an ECG
    Given I am a super user with all permissions
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
      | diag_statement     		                           |
      |Normal sinus rhythm  |

    When I click the add statement button
    Then the statement editor window should display
    When I type "test 1" into the statement editor window
    And I click on row 1 of search results
    And I click the ok button in statement editor window
    Then I should see the Edit/Confirm statement window with following statements in order
      | diag_statement     		                           |
      | Normal sinus rhythm  |
      | test 1                                             |

    When I click the Cancel button on top of Edit/Confirm statement window
    Then the Are You Sure window displays with message of "Any information you edited will be undone. Are you sure you want to undo edits?"
    When I click the Alert "No" button on the Are you sure window
    Then I should see the Edit/Confirm statement window with following statements in order
      | diag_statement     		                           |
      | Normal sinus rhythm |
      | test 1                                             |

    When I click the Cancel button on top of Edit/Confirm statement window
    Then the Are You Sure window displays with message of "Any information you edited will be undone. Are you sure you want to undo edits?"
    When I click the Alert "Yes" button on the Are you sure window
    When I click on the Edit button

    Then The Edit and Confirm window displays with a message including "This test was already confirmed by"
    When I click the alert continue button on Edit/Confirm window
    Then I should see the Edit/Confirm statement window with following statements in order
      | diag_statement     		                           |
      |Normal sinus rhythm |
