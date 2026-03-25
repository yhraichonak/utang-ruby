@atc @automated @el @critical @atc_at
@EPIC:FlightTracker @FEATURE:TimePicker
@clear_atc_flights
@TMS:586471 @ISSUE:XXXX-2119
@blocked @skip
Feature: at_time_picker
  As a Alert Tracker user
  I want to be able to navigate the Time Picker filter
  So that I can confirm correct behavior of the dashboard in response to the Time Picker filter

  XXXX-465
  Use common time picker and replace the current one
  Time Selection
  - Time Selection is the name of the dropdown
  - The dropdown options are Current and Time Range (historical mode)
  - When the user chooses Time Range mode, the last 6 hours of data displays
  - Add spinner as necessary when the user is "waiting"
  - The user should be notified if they choose time/date inconsistencies.
  - Start and End time should display the time chosen from the time picker
  - Time shall be a 24 hour clock not AM/PM
  - If the user changes from Time Range to Current then back to Time Range, Time Range should be sticky.

  This portion is covered in test C586559
  [- The ability to keyboard control/enter values in the field. It should be very easy to navigate and enter values with only the keyboard.
  a. should be possible for the user to tab not only between the field parts, but between start and end fields too.
  i. If the user hits the enter key on the keyboard, that should operate the same as the apply button.
  - A popout control to use the mouse to enter the values manually.
  - The popout should be able to provide mouse entry for the specific requirements of the field validation
  a. validation of the start/end values. Start MUST be before end.]

  The apply and cancel buttons are not visible until something is changed in one of the 2 range fields. a. cancel will reset the 2 fields back to what they were before. b. apply remains grayed out until all validation passes.
  TestRail Id: C586471

  Jira Story: XXXX-465

  Jira Bugs/Defects: XXXX-2119

  Scenario: Filtering the Dashboard with the Time Picker - General Navigation
    And FT: User is logged in with default filter applied
#  Scenario: Time Range reverts to previous selection when current selection is canceled
#  Scenario: Filtering the Dashboard with valid date ranges
#  Scenario: Filtering the Dashboard with invalid date ranges