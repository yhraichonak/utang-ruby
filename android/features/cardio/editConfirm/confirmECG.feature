@automated @TMS:40278 @cardio @cardio-edit_confirm @bvt
Feature: Confirm ECG
  As an AS1 user
  I want be able to edit and/or confirm an ECG
  So that I can make sure a patient's ECG has been verified by the user

  TestRail Id: C40278
@todofix
  Scenario: Edit and Confirm an ECG
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    And I click "Cardio Search" on the List
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
      | diag_statement                |
      | Normal sinus rhythm           |

    When I click the add statement button
    Then the statement editor window should display

    When I type "test 1" into the statement editor window
    And I click on row 1 of search results
    And I click the ok button in statement editor window
    Then I should see the Edit/Confirm statement window with following statements in order
      | diag_statement                |
      | Normal sinus rhythm           |
      | test 1                        |

    When I click the add statement button
    Then the statement editor window should display

    When I type "test 3" into the statement editor window
    And I click on row 1 of search results
    And I click the ok button in statement editor window
    Then I should see the Edit/Confirm statement window with following statements in order
      | diag_statement                |
      | Normal sinus rhythm           |
      | test 1                        |
      | test 3                        |

    When I hold and drag statement on row "3" to row "1" on screen
    Then I should see the Edit/Confirm statement window with following statements in order
      | diag_statement                |
      | test 3                        |
      | Normal sinus rhythm           |
      | test 1                        |

    When I click the 'X' button on row "3"
    Then I should see the Edit/Confirm statement window with following statements in order
      | diag_statement                |
      | test 3                        |
      | Normal sinus rhythm           |

    When I click the Confirm button on top of Edit/Confirm statement window
    Then The Edit and Confirm window displays with message of "Are you sure you want to confirm this ECG?"

    When I click the Alert "No" button on Edit/Confirm statement window
    Then I should see the Edit/Confirm statement window with following statements in order
      | diag_statement                |
      | test 3                        |
      | Normal sinus rhythm           |

    When I click the Confirm button on top of Edit/Confirm statement window
    Then The Edit and Confirm window displays with message of "Are you sure you want to confirm this ECG?"

    When I click the Alert "Yes" button on Edit/Confirm statement window
    Then The Edit and Confirm window displays with message of "Test Has Been Updated"
    When I click the alert OK button on Saving Statements window
    Then I should see the patient ECG screen

    When I click on the Edit button after confirming an ECG
    Then The Edit and Confirm window displays with a message including "This test was already confirmed by"
    When I click the alert continue button on Edit/Confirm window
    Then I should see the Edit/Confirm statement window with following statements in order
      | diag_statement                |
      | test 3                        |
      | Normal sinus rhythm           |

    When I click the 'X' button on row "1"
    Then I should see the Edit/Confirm statement window with following statements in order
      | diag_statement                |
      | Normal sinus rhythm           |

    When I click the Confirm button on top of Edit/Confirm statement window
    Then The Edit and Confirm window displays with message of "Are you sure you want to confirm this ECG?"
    When I click the Alert "Yes" button on Edit/Confirm statement window
    Then The Edit and Confirm window displays with message of "Test Has Been Updated"
    When I click the alert OK button on Saving Statements window
    Then I should see the patient ECG screen
