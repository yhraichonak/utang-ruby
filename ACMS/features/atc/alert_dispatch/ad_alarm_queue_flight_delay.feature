@atc @automated @el @critical @atc_ad
@EPIC:AirCommand @FEATURE:FlightDelay
@clear_atc_flights @TMS:590581
Feature: ad_alarm_queue_flight_delay
  As an Alert Dispatch User
  I want to click on the clock icon for a flight in the Alarm Queue
  So that I can verify that the flight delay feature works properly

  XXXX-1851
  - Flight Delay Time shall be configurable amount of time that is added or subtracted to initial suspense time of an individual flight plan.
  - Flight Delay Time can also be configured to have an infinite delay, which results in alarm that will not escalate.

  - Scenario 1:
  - The Flight Delay time shall be added to the Escalated Countdown timer.  For example:  Flight Delay time equals 00:30, and the escalated countdown timer is 00:19 when the user clicks on the clock icon, the escalated countdown timer shall display 00:49 (00:30+00:19) and count down 00:49, 00:48, 00:47, etc.

  - Scenario 2:
  - The Flight Delay time shall be subtracted from the Escalated Countdown timer.
  - Example 1:  If the Flight Delay time equals 00:30 and escalated countdown time is 00:39, when the user clicks on the clock icon, the Escalated count down time shall start counting down from 00:09, 00:08, 00:07, etc.
  - Example 2:  If the Flight Delay time equals 00:30 and the escalated countdown time 00.19 when the user clicks on the clock icon,  the escalated counter would be less than or equal to zero.  The alarm shall automatically resume it's flight plan and move to the Alert queue.

  - In the current implementation, the cases where an flight delay request submitted to the API will succeed but not apply any effect:
  - The Flight is not in InitialSuspense
  - isDelayed is passed as true and the Flight is already in delay.
  - isDelayed is passed as false and the Flight is not in delay.
  - These cases will not throw an error, they will return a 200 result, but they won't have any effect. The body of the response will provide information about the result of the request.Flight Delay Time shall be configurable amount (0 to 3600 seconds) of time that is added or subtracted to initial suspense time of an individual flight plan.
  - Flight Delay Time can also be configured to have an infinite delay, which results in alarm that will not escalate.

  - Scenario 1:
  - The Flight Delay time shall be added to the Escalated Countdown timer.  For example:  Flight Delay time equals 00:30, and the escalated countdown timer is 00:19 when the user clicks on the clock icon, the escalated countdown timer shall display 00:49 (00:30+00:19) and count down 00:49, 00:48, 00:47, etc.

  - Scenario 2:
  - The Flight Delay time shall be subtracted from the Escalated Countdown timer.
  - Example 1:  If the Flight Delay time equals 00:30 and escalated countdown time is 00:39, when the user clicks on the clock icon, the Escalated count down time shall start counting down from 00:09, 00:08, 00:07, etc.
  - Example 2:  If the Flight Delay time equals 00:30 and the escalated countdown time 00.19 when the user clicks on the clock icon,  the escalated counter would be less than or equal to zero.  The alarm shall automatically resume it's flight plan and move to the Alert queue.

  - In the current implementation, the cases where an flight delay request submitted to the API will succeed but not apply any effect:
  - The Flight is not in InitialSuspense
  - isDelayed is passed as true and the Flight is already in delay.
  - isDelayed is passed as false and the Flight is not in delay.
  - These cases will not throw an error, they will return a 200 result, but they won't have any effect. The body of the response will provide information about the result of the request.

  XXXX-1873
  - As a user when I click on the clock icon, the flight shall be in a delayed state in the Alarm Queue.
  - The Flight Delay time shall be added to the Escalated Countdown timer.

  - Scenario 1:  Flight Delay time equals 00:30, and the escalated countdown timer is 00:19
  - When the user clicks on the clock icon, the escalated countdown timer shall display 00:49 and count down 00:49, 00:48, 00:47, etc.

  - Scenario 2: Flight Delay time equals 00:00, and the escalated countdown timer is 00:19
  - When the user clicks on the clock icon, the escalated countdown timer shall display 00:19 and count down 00:19, 00:18, 00:17, etc.

  - Scenario 3: Flight Delay time equals infinity, and the escalated countdown timer is 00:19
  - When the user clicks on the clock icon the escalated countdown timer shall display +99.59.

  - The time box shall turn from utang blue to pale yellow.
  - The clock icon shall turn from white to utang blue.
  - The font color shall change from white to gray.
  - The status, located below "Time elapsed" shall change from "SUSPENDED" in white font to "DELAYED" in gray font.

  - As a user when I click on the clock icon in the delayed status:
  - The Flight Delay time shall be subtracted from the Escalated Count down timer.

  - Scenario 1:  Flight Delay time equals 00:30 and escalated countdown time is 00:39
  - When the user clicks on the clock icon, the Escalated count down time shall start counting down from 00:09, 00:08, 00:07, etc.

  - The time box shall turn from pale yellow to utang blue
  - The clock icon shall turn from utang blue to white
  - The font shall change from gray to white
  - The status, located below "Time Elapsed" shall change from "DELAYED" in gray to "SUSPENDED" in white font.

  - Additional scenarios
  - Scenario 2:  Flight Delay time equals 00:30 and the escalated countdown time is equal to or less than the Flight Delay time (e.g., 00:19 or 00:30)
  - When the user clicks on the clock icon, the escalated counter would be less than or equal to zero.  The alarm shall automatically resume it's flight plan and move to the Alert queue.

  **TESTING NOTES:**
  - Flight entry in suspended state visually:
  - flight status section of the flight entry is blue
  - clock icon in the top right of the flight entry is white
  - font color within the flight entry is white
  - status label is "SUSPENDED" and color is white
  - Flight entry in delayed state visually:
  - flight status section of the flight entry is pale yellow
  - clock icon in the top right of the flight entry is blue
  - font color within the flight entry is grey
  - status label is "DELAYED" and color is grey

  TestRail Id: C590390

  Jira Stories: XXXX-1851, XXXX-1873

  Jira Bugs/Defects: XXXX-2126

  Background:
    Given User executes test from "[props.CONFIGS_TC23_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied

  Scenario: Delay/undelay flight and observe the visual changes to flight chiclet
    When Alert "TC23_FlightDelay_Alarm_40" initiated on PM with 100 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    And AC: Flight alert status section is blue and has tabler-icon-clock icon with label Suspended
    And AC: Flight alert status section color is blue
    And AC: Flight alert status font color is white
    And AC: Flight alert "Escalation in" value counting down from "00:30" seconds
    And AC: Flight alert "Time Elapsed" value counting up from "00:00" seconds
    And AC: Wait until the flight "Escalation in" value is "00:20" for 10 seconds
    And AC: User click at clock icon on the flight in the top right hand corner
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    And AC: Flight alert "Escalation in" value counting down from "01:10" seconds
    And AC: Flight alert status section is yellow and has tabler-icon-clock icon with label Delayed
    And AC: Flight alert status font color is gray
    And AC: Wait until the flight "Escalation in" value is "00:50" for 10 seconds
    And AC: User click at clock icon on the flight in the top right hand corner
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    And AC: Flight alert "Escalation in" value counting down from "00:30" seconds
    And AC: Flight alert status section is blue and has tabler-icon-clock icon with label Suspended
    And AC: Flight alert status section color is blue
    And AC: Flight alert status font color is white

  Scenario: Delay flight and wait till time till escalation goes to 0 and escalates
    When Alert "TC23_FlightDelay_Alarm_40" initiated on PM with 100 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    And AC: Flight alert status section is blue and has tabler-icon-clock icon with label Suspended
    And AC: Flight alert "Escalation in" value counting down from "00:30" seconds
    And AC: Wait until the flight "Escalation in" value is "00:20" for 10 seconds
    And AC: User click at clock icon on the flight in the top right hand corner
    And AC: Flight alert status section is yellow and has tabler-icon-clock icon with label Delayed
    And AC: Wait until the flight "Escalation in" value is "00:50" for 10 seconds
    And AC: Wait until the flight "Escalation in" value is "00:00" for 50 seconds
    When API: Wait until the flight is escalated to level 1
    And AC: Flight alert status section is blue and has empty-circle icon with label Waiting
    And AC: User verifies the generated alert is present in Alerts panel with attributes
      """
      { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION23_SINGLEREC1]", "escalates-to": "destination:[props.DESTINATIONS_DESTINATION23_SINGLEREC2]"}
      """

  Scenario: Delay flight and undelay while the time till escalation is greater than the flight delay value
    When Alert "TC23_FlightDelay_Alarm_40" initiated on PM with 100 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    And AC: Flight alert status section is blue and has tabler-icon-clock icon with label Suspended
    And AC: Flight alert "Escalation in" value counting down from "00:30" seconds
    And AC: Wait until the flight "Escalation in" value is "00:20" for 10 seconds
    And AC: User click at clock icon on the flight in the top right hand corner
    And AC: Flight alert status section is yellow and has tabler-icon-clock icon with label Delayed
    And AC: Wait until the flight "Escalation in" value is "00:50" for 10 seconds
    And AC: User click at clock icon on the flight in the top right hand corner
    And AC: Flight alert status section is blue and has tabler-icon-clock icon with label Suspended
    And AC: Flight alert "Escalation in" value counting down from "00:30" seconds
    And AC: Wait until the flight "Escalation in" value is "00:00" for 20 seconds
    When API: Wait until the flight is escalated to level 1
    And AC: Flight alert status section is blue and has empty-circle icon with label Waiting
    And AC: User verifies the generated alert is present in Alerts panel with attributes
      """
      { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION23_SINGLEREC1]", "escalates-to": "destination:[props.DESTINATIONS_DESTINATION23_SINGLEREC2]"}
      """

  Scenario: Delay flight and undelay while the time till escalation is less than the flight delay value
    When Alert "TC23_FlightDelay_Alarm_40" initiated on PM with 100 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    And AC: Flight alert status section is blue and has tabler-icon-clock icon with label Suspended
    And AC: Flight alert "Escalation in" value counting down from "00:30" seconds
    And AC: Wait until the flight "Escalation in" value is "00:25" for 10 seconds
    And AC: User click at clock icon on the flight in the top right hand corner
    And AC: Flight alert status section is yellow and has tabler-icon-clock icon with label Delayed
    And AC: Wait until the flight "Escalation in" value is "00:45" for 40 seconds
    And AC: User click at clock icon on the flight in the top right hand corner
    And AC: Flight alert status section is blue and has tabler-icon-clock icon with label Suspended
    And AC: Wait until the flight "Escalation in" value is "00:05" for 1 seconds
    When API: Wait until the flight is escalated to level 1
    And AC: Flight alert status section is blue and has empty-circle icon with label Waiting
    And AC: User verifies the generated alert is present in Alerts panel with attributes
      """
      { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION23_SINGLEREC1]", "escalates-to": "destination:[props.DESTINATIONS_DESTINATION23_SINGLEREC2]"}
      """

  Scenario: Delay flight by infinity and undelay while time elapsed is greater than the initial suspense value
    When Alert "TC23_FlightDelay_Alarm_Infinity" initiated on PM with 100 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    And AC: Flight alert status section is blue and has tabler-icon-clock icon with label Suspended
    And AC: Flight alert "Escalation in" value counting down from "00:30" seconds
    And AC: Wait until the flight "Escalation in" value is "00:25" for 5 seconds
    And AC: User click at clock icon on the flight in the top right hand corner
    And AC: Flight alert status section is yellow and has tabler-icon-clock icon with label Delayed
    And AC: Flight alert "Escalation in" value is "--"
    And AC: Flight alert "Elapsed time" value counting up
    And AC: Wait until the flight "Time elapsed" value is "00:35" for 35 seconds
    And AC: User click at clock icon on the flight in the top right hand corner
    And AC: Flight alert status section is blue and has tabler-icon-clock icon with label Suspended
    When API: Wait until the flight is escalated to level 1
    And AC: Flight alert status section is blue and has empty-circle icon with label Waiting
    And AC: User verifies the generated alert is present in Alerts panel with attributes
    """
    { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION23_SINGLEREC1]", "escalates-to": "destination:[props.DESTINATIONS_DESTINATION23_SINGLEREC2]"}
    """

  Scenario: Delay flight by infinity and undelay while time elapsed is less than the initial suspense value
    When Alert "TC23_FlightDelay_Alarm_Infinity" initiated on PM with 100 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    And AC: Flight alert status section is blue and has tabler-icon-clock icon with label Suspended
    And AC: Flight alert "Escalation in" value counting down from "00:30" seconds
    And AC: Wait until the flight "Escalation in" value is "00:25" for 5 seconds
    And AC: User click at clock icon on the flight in the top right hand corner
    And AC: Flight alert status section is yellow and has tabler-icon-clock icon with label Delayed
    And AC: Flight alert "Escalation in" value is "--"
    And AC: Flight alert "Elapsed time" value counting up
    And AC: Wait until the flight "Time elapsed" value is "00:20" for 20 seconds
    And AC: User click at clock icon on the flight in the top right hand corner
    And AC: Flight alert status section is blue and has tabler-icon-clock icon with label Suspended
    And AC: Flight alert "Escalation in" value counting down from "00:10" seconds
    And AC: Wait until the flight "Escalation in" value is "00:00" for 10 seconds
    When API: Wait until the flight is escalated to level 1
    And AC: Flight alert status section is blue and has empty-circle icon with label Waiting
    And AC: User verifies the generated alert is present in Alerts panel with attributes
    """
    { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION23_SINGLEREC1]", "escalates-to": "destination:[props.DESTINATIONS_DESTINATION23_SINGLEREC2]"}
    """

  Scenario: Delay flight by 0 and undelay
    When Alert "TC23_FlightDelay_Alarm_Zero" initiated on PM with 100 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    And AC: Flight alert status section is blue and has tabler-icon-clock icon with label Suspended
    And AC: Flight alert "Escalation in" value counting down from "00:30" seconds
    And AC: Wait until the flight "Escalation in" value is "00:25" for 5 seconds
    And AC: User click at clock icon on the flight in the top right hand corner
    And AC: Flight alert "Escalation in" value counting down from "00:30" seconds
    And AC: Flight alert status section is yellow and has tabler-icon-clock icon with label Delayed
    And AC: Flight alert "Escalation in" value counting down from "00:30" seconds
    And AC: User click at clock icon on the flight in the top right hand corner
    And AC: Flight alert status section is blue and has tabler-icon-clock icon with label Suspended
    And AC: Flight alert "Escalation in" value counting down from "00:30" seconds
    And AC: Wait until the flight "Escalation in" value is "00:00" for 30 seconds
    When API: Wait until the flight is escalated to level 1
    And AC: Flight alert status section is blue and has empty-circle icon with label Waiting
    And AC: User verifies the generated alert is present in Alerts panel with attributes
    """
    { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION23_SINGLEREC1]", "escalates-to": "destination:[props.DESTINATIONS_DESTINATION23_SINGLEREC2]"}
    """

