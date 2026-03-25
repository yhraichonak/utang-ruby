@regression @smoke @manual @automated @critical @TMS:316546 @c3po
Feature: c3po_pmEvents.feature
  TestRail Id: C316546
  Jira Stories: MIG-248, AS1-7240
  Jira Bug/ Defects: AS1-4425

  Description
  3rd party applications will be able to open a view into the HTML5 web client directly to a particular patient and a
  particular view of that patient. (PM Only at this time)

  Note(s):

  C3P0 is built on top of ShareLinks. The C3P0 payload from a 3rd party is forwarded to the FED server for processing.
  The fed server takes care of knowing how to handle authentication and decypher the encrypted payload. The fed server
  also calculates the correct ShareLink URL that the client needs to view the patient information.
  There is a reference C3P0 app for both Android and iOS that can be used to generate valid C3P0 payloads.
  C3P0 URis are a modification to the already established ShareLink URIs. The primary difference being the change in the
  "host" component of the URI. Any "host" component that is NOT "utang" is to be treated as a C3P0 based request.
  C3P0 Server Decryption URL. When a 3rd party triggers a C3P0 call on the AS1 client, the AS1 client will forwards the
  request to the FED server for processing. No AuthToken is required.

  3RD party Requests

  All AS1 clients receive C3P0 requests in a means specific to their platform. For WEB, this will be a URL at a
  pre-defined relative location. "<relative install path>/api/sharelink" . This location is currently in use at CCF, and
  will be retained for backwards compatibility of their 3rd party app with our new HTML client code.

  Scenario: PM C3P0 Launch - PM events
    Given I open C3PO URL generation interface
    And I generate pm-evt ascom C3PO url with query TEST=1234567890&ad=username&bed=QA1&unit=ATQA
    And I navigate to the generated C3PO url
    Then I should see the Events screen displayed
