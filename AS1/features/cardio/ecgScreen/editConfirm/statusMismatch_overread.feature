@regression @editConfirm @automated @core
Feature: Edit/Confirm - overread/status mismatch
  E/C Overread Prompt

  When a user taps the Edit button on a Confirmed test, the system should check who the test was confirmed by and prompt
  the user with:
  Header: Already Confirmed"This test was already confirmed by XYZ. Do you wish to continue?"Button options - Cancel and
  ContinueCancel returns them to the ECG, without going into Edit modeContinue takes the user into Edit mode

  E/C - Status Mismatch check

  The system will check if the status of the test in AST db matches the status of the test in MUSE.e.g. If the status in
  AST is UNCONFIRMED and the status in MUSE is CONFIRMED (Status mismatch), then prompt the user. This check must be done
  on user tap of "Edit" button and "Confirm" button.

  Header: ErrorPrompt wording:"The information for this test is out of date. Unable to Edit/Confirm at this time."prompt
  will have an "OK" button that:

  in a tap of "Edit" context will prevent the user from entering Edit Mode

  in a tap of "Confirm" context will exit Edit Mode and not save the user's in progress edits

  Under both contexts the client must reload the ECG after the "OK" button is pressed on the prompt.

  This status mismatch check will be the last check in the series of checks.For "Edit" button, the sequence of system
  checks is:1) Check for locked record and trigger Record Locked prompt2) Check if already confirmed and trigger Overread
  prompt3) Check for status mismatch and trigger Status Mismatch prompt

  For "Confirm" button, the sequence of system checks is:1) Check for locked record and trigger Record Locked prompt2)
  Check for status mismatch and trigger Status Mismatch prompt

  TestRail Id: C580268
  Jira Issues: AS1-2470

  Scenario: Edit/Confirm - status mismatch
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "MOST RECENT" on the List
    Then I should see the patient list screen
    When I click on "Nesbitt, Esron" in patient list
    Then I should see the patient summary screen
    When I click on the ECG tile
    Then I should see the ecg list on ECG screen
    And I should see patient info in ecg screen header
    When I click on row "1" on ecg list
    Then I should see the patient ECG screen
    When I click on the info icon on the ecg toolbar
    Then the ecg detailed info drawer displays
    When I click on the info icon on the ecg toolbar
    Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display

    When I click the Edit button on ECG screen
    Then The Edit Confirm window displays with a message including "This test was already confirmed by"
    When I click Ok in cardio message window
    Then I should see the patient ECG screen

  Scenario: Edit/Confirm - overread
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "MOST RECENT" on the List
    Then I should see the patient list screen
    When I click on "Nesbitt, Esron" in patient list
    Then I should see the patient summary screen
    When I click on the ECG tile
    Then I should see the ecg list on ECG screen
    And I should see patient info in ecg screen header
    When I click on row "1" on ecg list
    Then I should see the patient ECG screen
    When I click on the info icon on the ecg toolbar
    Then the ecg detailed info drawer displays
    When I click on the info icon on the ecg toolbar
    Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display

    When I click the Edit button on ECG screen
    Then The Edit Confirm window displays with a message including "This test was already confirmed by"
    When I click Cancel in cardio message window
    Then I should see the patient ECG screen

    When I click the Edit button on ECG screen
    Then The Edit Confirm window displays with a message including "This test was already confirmed by"
    When I click Ok in cardio message window
    Then I see the Edit Confirm window appear on right side of ECG screen

    When I click the Confirm button in Edit Confirm window
    Then I should see prompt to Confirm or Cancel
    When I click Cancel button in Confirm or Cancel prompt window
    Then I should see the patient ECG screen
    And I see the Edit Confirm window appear on right side of ECG screen

    When I click the Confirm button in Edit Confirm window
    Then I should see prompt to Confirm or Cancel
    When I click Confirm button in Confirm or Cancel prompt window
    Then I should see a Confirmation prompt window appear
    When I click the OK button in Confirmation prompt window
    Then I should see the patient ECG screen