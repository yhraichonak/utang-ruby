@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:AlertDetails
@TMS:586324 @clear_atc_flights
Feature: ad_alarm_queue_patient_cell
  As an Alert Dispatch User
  I want to view the Alerts column patient cell
  So that I verify its display

  XXXX-926
  Alerts - Chicklets
  Should display the following:
  - alarm icon (high, medium, low) on top left
  - alarm name
  - Patient Name (last name, first name)
  - birth date, MRN
  - Unit and room number + bed appended with hyphen
  - Facility Name
  - Time of alarm when it starts, out of a 24 hour clock to the seconds (Example: 08:13:52)
  - Time alarm has been active to the seconds (Example: 04:15)
  Assigned To: <-[Assigned To has been deprecated by XXXX-2146 and is now "Level#:"]
  Esclates To:
  - Completed Flights shall not have a timer.

  TestRail Id: C586324

  Jira Stories: XXXX-926

  Jira Bugs/Defects: XXXX-1403

  Scenario: Alert Dispatch Alerts Column - Patient Cell Display
    Given User executes test from "[props.CONFIGS_TC05_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied
    When Alert "TC05_Medium_Alarm_Short" initiated on PM with 10 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alerts panel with Medium severity
    Then AC: User verifies the generated alert is present in Alerts panel with matching text
    """
    (?m).*TC05_Medium_Alarm_Short.*Smith,.Jim.06/01/2000.2233441.*
    """
    Then AC: User verifies the generated alert is present in Alerts panel with matching text
    """
    (?m).*Level 1.*Destination1_SingleRec_tc05_multi.*Escalates To.*None.*
    """
    Then AC: User verifies the generated alert is present in Alerts panel with matching text
    """
    (?m).*Facility1.ICU3.ICU3-B890.\d\d:\d\d:\d\d.*
    """
    When API: Wait until the flight status is Complete by Flight Manager for 30 seconds
    Then AC: User should see "TC05_Medium_Alarm_Short" alert present in Alerts panel in Completed subsection without timer
