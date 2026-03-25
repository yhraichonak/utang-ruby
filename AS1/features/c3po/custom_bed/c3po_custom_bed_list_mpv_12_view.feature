@regression @manual @automated @TMS:582453 @c3po
Feature: C3PO - Custom Bed MPV - 12 View
  TestRail Id: C582453
  Jira Epic: AS1-2518
  Jira Stories: AS1-4217, AS1-4232
  Jira Bugs/Defects:

  As an utang ONE user
  I want to open an encrypted C3PO link
  So that I can launch the 12 Monitor Multi Patient View for the Custom Bed list

  AS1-4217
  Allow for a C3PO link to MPV
  - Client Type: (required) Has to be set to “ast”.
  - App path: (required) Echoed back in sharelink response.
  - Parameters can be in any order
  parameters:
  siteid - (required)
  listIndex - (required) This index is defined on the web front-end. It can be used to select either patient-lists or
  custom-bed-lists This parameter will eventually be replaced by a listId defined on the server.
  - Additional query parameters will be echoed back in the sharelink response message.

  AS1-4232
  Web client needs to be able to handle updated C3PO link to MPV (additional properties) such as:
  - Bedlist/list name (target list)
  - MPV view type (such as 4 view, condensed PM view etc)
  - Zoom settings/configurations (condensed PM zoom view, PM zoom level, etc)
  - PHI Hidden/Shown
  - Client Type: (required) Has to be set to “ast”

  The route is setup like this: "http://localhost:3000/#/api/sharelink/ast/pm-mpv?siteid=2244&moduleId=3&view=4&listIndex=3&zoom=5&monitorZoom=9&phi=true"

  Parameters can be in any order parameters: siteid: (required) listIndex: (required) This index is defined on the web front-end.
  It can be used to select either patient-lists or custom-bed-lists This parameter will eventually be replaced by a listId defined
  on the server. moduleId: (optional / ignored) view: optional (number) number of tiles to open full monitors in. If this is omitted
  surveil will default to condensed monitors. zoom: (optional) value from 1-10 monitorZoom: (optional) value from 1-10 phi: (optional) (true | false)

  Notes:
  - For the below scenarios, the site URL and site ID may vary depending on the site used for testing, update those values as needed.
  - The "listIndex" parameter within the Query will also vary depending on the site used. When you go to the patient list, each option
  in the list of lists has an index. That index will be on the end of URL in the address bar.
  - When PHI is set to TRUE, the PHI information is visible. When the PHI is set to FALSE, the PHI information is hidden.

  Scenario: C3PO link opens 12 Monitor MPV for Custom Bed list with PHI visible
    Given I open C3PO URL generation interface
    And I generate pm-mpv ast C3PO url with query TEST=1234567890&ad=username&moduleId=[prop.COMMON_PM_MODULE_ID]&listIndex=[props.COMMON_CUSTOM_PATIENT_LIST_ID]&view=12&zoom=5&monitorZoom=2&phi=true
    And I navigate to the generated C3PO url
    Then I should see "12" condensed monitors on c3po MPV screen
    And I should see patient names, zoom control, demographics, location, alarms, and 1 waveform if monitor screen displayed
    And I should see the Hide PHI button not highlighted

  Scenario: C3PO link opens 12 Monitor MPV for Custom Bed list with PHI hidden
    Given I open C3PO URL generation interface
    And I generate pm-mpv ast C3PO url with query TEST=1234567890&ad=username&moduleId=[prop.COMMON_PM_MODULE_ID]&listIndex=[props.COMMON_CUSTOM_PATIENT_LIST_ID]&view=12&zoom=5&monitorZoom=2&phi=false
    And I navigate to the generated C3PO url
    Then I should see "12" condensed monitors on c3po MPV screen
    And I should see patient names, zoom control, demographics, location, alarms, and 1 waveform if monitor screen displayed
    And I should see the Hide PHI button highlighted
