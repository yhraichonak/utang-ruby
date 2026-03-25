@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:AlertDetails
@TMS:586386 @clear_atc_flights
Feature: ad_alert_details_flight
  As an Alert Dispatch user
  I want to view flight details of a flight
  So that I can confirm the needed information is present

  XXXX-1542
  - As a user, when I click on flight '<id>' in Alarm Queue, the flight details panel shall display.
  - As a user, when I click on flight '<id>' in Alerts Queue, the flight details panel should display.

  Display Destinations on Flight Status Panel:

  The UI should display:
  - The alert details at the top of the window, includes:
  Alarm icon and Alarm name
  Below the Alarm details:
  - Patient Name (last, first)
  - DOB (DOT separator) Patient MRN (DOT separator)
  - Assigned To and Escalates To display on 'in Flight' flights <-[Assigned To has been deprecated by XXXX-2146 and is now "Level #:"]
  - Hospital Name (DOT separator) Unit (DOT separator) Room shall be right aligned in the patient cell

  Interaction
  - Flight Details Panel will appear on the right side of the screen when a user clicks directly on a chicklet/flight
  - User will be able to scroll through history if user cannot view all history
  Page Sort
  - Users will be able to tab through 3 focus modes: History, Audit and Monitor (Default "History")
  - The user will be able to click back and forth between these tabs
  - Whatever actions that can be taken for the specific alarm will display on the right of the focus mode below the alarm information and above the listed history (i.e. Start, EMG)
  If I click one of these buttons, it will follow the same path
  Close Button:
  - Add a close button (an 'X') to the details panel to provide the user with the ability to close the panel without clicking on the flight.
  - The flight will be deselected once the panel is closed

  XXXX-1956
  In Alert Dispatch, under the Alerts Column, change "In Flight" to "Active". Attached is a screen shot for reference.

  XXXX-2146
  - "Assigned To" field label shall change to "Level #:" where # represents the escalation level in the escalation pathway.
  - This field shall show the current escalation level and the role and first name of the assigned person. (Example: "Level 3:" RN2 (Patty))

  TESTING NOTES:
  - How-To create an alert flight - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually

  TestRail Id: C586386

  Jira Stories: XXXX-1542, XXXX-1956, XXXX-2146

  Jira Bugs/Defects: XXXX-1741, XXXX-1403

  Scenario: Display flight details of a row in Alarm Queue panel
    Given User executes test from "[props.CONFIGS_TC09_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC09_01_Alarm,TC09_02_Alarm" initiated on PM with 100 seconds timeout
    And AC: User is logged in with default filter applied
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel with attributes
      """
      { "alarm-label":"TC09_02_Alarm"}
      """
   And AC: User opens the generated alert details in Alarm Queue panel
    And wait for 2 seconds
   And AC: User verifies that the generated alert card is highlighted in Alarm Queue panel
   Then AC: User verifies that the alert details panel is opened
   Then AC: User verifies that the alert details has matching text
  """
 (?m).*TC09_02_Alarm.*Smith, Jim.06/01/2000.2233441.Facility1.ICU3.ICU3-B890.\d\d:\d\d:\d\d.*
"""
  And AC: User verifies that the alert details has Start button
  Then AC: User verifies that the alert details has tab History active
  Then AC: User verifies that the alert details has matching text
  """
 (?m).*FlightInitialSuspenseStart.Initial.Suspense.started.*Timeout.*\d\d\d\d-\d\d-\d\dT\d\d\:\d\d\:\d\d-\d\d\:\d\d.\d\d/\d\d/\d\d\d\d.\d\d\:\d\d\:\d\d.*
 .*NewFlightCreated.*AlarmId.*
"""
    And AC: User opens Monitor tab of the alert details panel
    Then AC: User verifies that the alert details has tab Monitor active
    Then AC: User verifies that monitor is displayed on the alert details
    When  AC: User closes generated alert details panel
    Then AC: User verifies that the alert details panel is closed
    And AC: User verifies that the generated alert card isn't highlighted in Alarm Queue panel
    And AC: User opens the "TC09_01_Alarm" alert details in Alarm Queue panel
    And AC: User verifies that "TC09_01_Alarm" alert card is highlighted in Alarm Queue panel
    Then AC: User verifies that the alert details panel is opened
    Then AC: User verifies that the alert details has matching text
  """
 (?m).*TC09_01_Alarm.*
  """

  Scenario: Display flight details of a row in the Active section of the Alerts panel
    Given User executes test from "[props.CONFIGS_TC05_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC05_Medium_Alarm_Short,TC05_Low_Alarm_Short" initiated on PM with 50 seconds timeout
    And AC: User is logged in with default filter applied
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight status is Escalated by Flight Manager
    And AC: User wait until "TC05_Low_Alarm_Short" alert appears in Alerts panel in Active subsection
    And AC: User opens the generated alert details in Alerts panel
    And AC: User verifies that the generated alert card is highlighted in Alerts panel
    Then AC: User verifies that the alert details panel is opened
    Then AC: User verifies that the alert details has matching text
  """
 (?m).*TC05_Low_Alarm_Short.*Smith,.Jim.06/01/2000.2233441.*
"""
    Then AC: User verifies that the alert details has matching text
  """
 (?m).*Level 1:.Destination1_SingleRec_tc05_multi_accept.Escalates To:.None.*Facility1.ICU3.ICU3-B890.*
"""
    Then AC: User verifies that the alert details has tab History active
    Then AC: User verifies that the alert details has matching text
  """
 (?m).*FlightInitialSuspenseStart.Initial.Suspense.started.*Timeout.*\d\d\d\d-\d\d-\d\dT\d\d\:\d\d\:\d\d-\d\d\:\d\d.\d\d/\d\d/\d\d\d\d.\d\d\:\d\d\:\d\d.*
 .*NewFlightCreated.*AlarmId.*
"""
    And AC: User opens Monitor tab of the alert details panel
    Then AC: User verifies that the alert details has tab Monitor active
    Then AC: User verifies that monitor is displayed on the alert details
    When  AC: User closes generated alert details panel
    Then AC: User verifies that the alert details panel is closed
    And AC: User verifies that the generated alert card isn't highlighted in Alerts panel
    And AC: User opens the "TC05_Medium_Alarm_Short" alert details in Alerts panel
    And AC: User verifies that "TC05_Medium_Alarm_Short" alert card is highlighted in Alerts panel
    Then AC: User verifies that the alert details panel is opened
    Then AC: User verifies that the alert details has matching text
  """
 (?m).*TC05_Medium_Alarm_Short.*
  """