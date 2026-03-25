@regression @editConfirm @automated @core
Feature: Edit/Confirm - Cancel
  Edit/Confirm
  E/C - Edit Button
  NOTE - this button should be disabled in Serial Presentation mode.

  The Edit button should function as follows; When configured for display, the Edit Button should display in right-aligned
  secondary navigation, to the left of "Compare" (Separated by a pipe)
  when user or site not configured for E/C, the Edit button and pipe separator should not display When the Edit button
  is tapped, the Edit Form will appear in a similar manner to the "Compare" function where the ECG
  remains visible on the left while a secondary control is opened on the right (ratio of 60/40 where 40 is the Edit form)
  NOTE - If a user attempts to Edit an ECG that is locked by another user they will receive a dismissable prompt - "This
  ECG is locked by another user" (message text controlled by Client Server)
  E/C - Edit Mode
  The Edit form will include "Confirm" button and "Cancel" button, which are sticky at the bottom of Edit Mode form.
  While edit mode is active, the ECG list selection in Vertical toolbar will be disabled (not hidden).
  While edit mode is active, the Primary Navigation will ( collapse)

  Confirm Button
  when the "Confirm" button is tapped, the system will check if the ECG can be confirmed, if it can, then a Confirmation
  successful prompt should appear. When the Confirmation prompt is dismissed, the Edit form should be closed and the ECG
  will return full-screen view

  Header: Confirm ECG simple "Are you sure you want to confirm this ECG?" prompt with Confirm/Cancel options.
  Confirm continues the confirm action. Sends confirmation and returns user to ECG screen.

  failed confirmation will return the user to ECG as well, with confirmation failed messaging.
  Cancel - cancels the action and returns the user to Edit/Confirm form.

  Cancel Button
  Tapping Cancel will result in a prompt for the user to confirm their desire to leave Edit mode and lose their information

  Header: none
  "Any information you edited will be undone. Are you sure you want to undo edits?"
  Undo Edits - continues the Cancel action. Returns user to ECG full screen mode.
  Cancel - cancels the Cancel action, returns user to Edit/Confirm form.

  TestRail Id: C554792
  Jira Issues: AS1-2463, AS1-2469, AS1-2786, AS1-2464, AS1-2994, AS1-3183

  Scenario: Edit/Confirm - Cancel button
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
    Then I see the Edit Confirm window appear on right side of ECG screen
    And I should see the ecg list button disabled
    And I should see a total of 1 statements in Edit Confirm window

    When I click the Append Statement button
    Then I should see a new statement row added in the Edit Confirm window
    When I type "AB" on the new statement row in the Edit Confirm window
    Then I should see the statement library selection window appear with values that start with "AB"
    When I select "AB :Abnormal ECG" in statement library selection window
    Then I should see "Abnormal ECG" display in new statement row in Edit Confirm window
    And I should see a total of 2 statements in Edit Confirm window

    When I click the Append Statement button
    Then I should see a new statement row added in the Edit Confirm window
    When I type "test1" on the new statement row in the Edit Confirm window
    Then I should see the statement library selection window appear with values that start with "test1"
    When I select "test1" in statement library selection window
    Then I should see "test1" display in new statement row in Edit Confirm window
    And I should see a total of 3 statements in Edit Confirm window

    When I click the Append Statement button
    Then I should see a new statement row added in the Edit Confirm window
    When I type "test2" on the new statement row in the Edit Confirm window
    Then I should see the statement library selection window appear with values that start with "test2"
    When I select "test2" in statement library selection window
    Then I should see "test2" display in new statement row in Edit Confirm window
    And I should see a total of 4 statements in Edit Confirm window

    When I click the delete statement icon for the statement "test1"
    Then I should see the statement row with "test1" deleted
    And I should see a total of 3 statements in Edit Confirm window

    When I click the Cancel button in Edit Confirm window
    Then I should see prompt to Undo Edits or cancel request
    When I click Cancel button in Undo Edits prompt window
    Then I should see the patient ECG screen
    And I see the Edit Confirm window appear on right side of ECG screen

    When I click the Cancel button in Edit Confirm window
    Then I should see prompt to Undo Edits or cancel request
    When I click Undo Edits button in Undo Edits prompt window
    Then I should see the patient ECG screen

    When I click the Edit button on ECG screen
    Then I see the Edit Confirm window appear on right side of ECG screen
    And I should see a total of 1 statements in Edit Confirm window
    And I should see the ecg list button disabled

  Scenario: Edit/Confirm - Cancel (Patient Header Back button)
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
    Then I see the Edit Confirm window appear on right side of ECG screen
    And I should see the ecg list button disabled

    When I click the Back button in patient header
    Then I should see browser prompt to Undo Edits or cancel request
    When I click Cancel button in Undo Edits browser prompt window
    Then I should see the patient ECG screen
    And I see the Edit Confirm window appear on right side of ECG screen

    When I click the Back button in patient header
    Then I should see browser prompt to Undo Edits or cancel request
    When I click Undo Edits button in Undo Edits browser prompt window
    Then I should see the patient list screen

  Scenario: Edit/Confirm - Cancel (Home button)
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
    Then I see the Edit Confirm window appear on right side of ECG screen
    And I should see the ecg list button disabled

    When I click the Home icon
    Then I should see browser prompt to Undo Edits or cancel request
    When I click Cancel button in Undo Edits browser prompt window
    Then I should see the patient ECG screen
    And I see the Edit Confirm window appear on right side of ECG screen

    When I click the Home icon
    Then I should see browser prompt to Undo Edits or cancel request
    When I click Undo Edits button in Undo Edits browser prompt window
    Then I should see the patient list screen