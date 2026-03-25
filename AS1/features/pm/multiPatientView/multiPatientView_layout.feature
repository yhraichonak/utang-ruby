@smoke @multiPatient @nodeSim @regression @automated @pm @pm-multi_patient_view
Feature: Multi-Patient View - layout
  LAYOUT
  The PM Multi-Patient view consists of a header that allows the user to do GB/SB, Filter and Search and it has space that displays the
  Condensed Patient Monitor Boxes.
  Condensed Patient Monitor Boxes – For one patient the Condensed Patient Monitor boxes displays demographics, location, alarm, 1 waveform
  and parameters.
  User can only expand one Condensed Patient Monitor Box at a time
  The 1st lead in the prioritization stack needs to be streaming and visible
  Alarms need to show (same rules as PM monitor) Reference AS1-XXX
  Display Multiple Alarms as PM Reference AS1-XXXX for multiple alarm logic
  Default Sort by Bed
  Default Sort is Left to right, top to bottom
  There are two Modes/States to the PM Multi-Patient View
  Mode 1- All Condensed Patient Monitor Boxes display in a collapsed state. When there is more than fits the screen, there is a general
  vertical scroll bar the entire length of the page to view the whole screen. The boxes are organized left to right, bottom to top.
  Mode 2/Focused State: Once I click on a Patient Monitor box, then that becomes my focus and the view changes to the Patient Monitoring
  Preview Mode. The layout of the boxes turns into a single row that reads left to right. The vertical scroll bar now changes to a horizontal
  scroll bar to support the new page layout in order to see all the patients organized left to right.
  In Mode 2, the condensed box on the top view needs to have a selected state. Currently an “eye’’ icon exists in the prototype, but there
  may be an issue with color depending on the color of the header.Does the eye switch to a grey to a white, therefore causing the display
  to be too subtle? TBD – Ask Neil if this is ok for first Phase.When I click on the Condensed Monitor Boxes, this spaces shows and follows all
  the same rules as the PM View Reference EPIC/JIRA AS1-XXXX

  Header:Maintain the header to include Group/Sort, Filter Units, Search (left aligned)
  In the center of the Header, display the following:Units: Name, Name, Name
  In the GBSB Header space - show the Server Time
  The Group/Sort story to reference is AS1-XXX
  Group/Sort and Filter Units:
  The default view is the first unit of the unit list. Reference AS1-XXX for GB/SB rules
  The user may pick different values. If the user changes GBSB, the application will save that preference in the user’s preference.
  Upon login, the new preferences will be remembered.Note: There is no Unit header separator
  The Filter Sort story to reference is AS1-XXXAllow the user to perform a search by selecting Search from the headerThe Search story
  to reference is AS1-XXX
  Open QuestionsIs the search literally an on screen search to find whatever matches or is it a Value SearchWhen the user has the PM
  Monitoring Preview Mode screen opened, how does the Search behave? Does it become disabled?Does Gb/SB filter and search both become
  disabled?What happens when the PM Monitor view is expanded?

  TestRail Id: C580255
  Jira Epic: AS1-2809
  Jira Stories: AS1-2815, AS1-2816, AS1-3054, AS1-3560
  Jira Bugs/Defects: AS1-2871, AS1-2908, AS1-2904, AS1-2883, AS1-2987, AS1-2980, AS1-3031, AS1-3632, AS1-3603, AS1-3884, AS1-4721

  @critical @TMS:580255 @ISSUE:AS1-7389
  Scenario: Multi-Patient View - layout
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    And I clear grouping on patients list
    And I click on patient "[props.MPV_FULL_NAME]" star icon to "enabled"
    When I click "My Patients" on the List
    And I clear grouping on patients list
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see patients demographics, location, alarms, and 1 waveform with parameters in each condensed monitor

    And I should get the single lead header objects for patient "1"
    And I should see the name field display on the single lead view for patient "1"
    And I should see location field display on the single lead view for patient "1"

    And I should get the single lead discrete objects for patient "1"
    And I should see heart rate field display with title "HR bpm" on the single lead view for patient "1"
    And I should see rr bpm field display with title "matches:(RR bpm|RR-ECG bpm)" on the single lead view for patient "1"
    And I should see PVC field display with title "matches:(PVC bpm|PVC Bpm)" on the single lead view for patient "1"

    And I should get the single lead header objects for patient "2"
    And I should see the name field display on the single lead view for patient "2"
    And I should see location field display on the single lead view for patient "2"

    And I should get the single lead discrete objects for patient "2"
    And I should see heart rate field display with title "HR bpm" on the single lead view for patient "2"
    And I should see rr bpm field display with title "matches:(RR bpm|RR-ECG bpm)" on the single lead view for patient "2"
    And I should see PVC field display with title "matches:(PVC bpm|PVC Bpm)" on the single lead view for patient "2"

    And I should not ST discrete blocks display on condensed monitors
    And I should see default sort by Bed left to right then top to bottom
    And I should see the zoom control toggle in header
    And I should see condensed monitor control button in header
    And I should see condensed monitor control button is enabled in the header
    And I should see dual monitor control button in header
    And I should see quad monitor control button in header
    And I should see 6 view monitor control button in header
    And I should see 9 view monitor control button in header
    And I should see 12 view monitor control button in header
    And I should see 16 view monitor control button in header

    When I click on individual condensed patient monitor on Multi Patient View screen
    Then I should see the selected patient monitor open on left side of Multi Patient View in split screen mode

    When I click on any condensed monitor above
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
