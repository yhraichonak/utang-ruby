@regression @manual @automated @core
Feature: Rejected Snippet - ops log
  Add Nurse Approval data to Snippets Ops Log:
  Approver
  Date/time of approval or Rejection
  PDF Creator
  Date/time or PDF creation
  SessionID
  SiteID
  PatientID (ASMPID)

  Note: SELECT * FROM [utangServer].[dbo].[OperationLog] WHERE OperationType in ('SnippetRejected') ORDER BY Timestamp_UTC desc

  TestRail Id: C329212
  Jira Stories: AS1-2347
  @unapproved_snippet_created @TMS:329212
  Scenario: Rejected Snippet - ops log
    Given I am a super user with all permissions
    When user config for the user is updated with
    """
    [props.COMMON_RESET_SNIPPET_FILTER_CONFIG]
    """
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Snippets Report" on the List
    Then I should see the Supervisor Snippet Report screen
    When I reset Status column filter
    When I click the Status field and should see the following options:
      | Pending |
      | N/A |
      | Rejected |
      | Approved |
    Then I click on Status dropdown and select "Pending"
    Then I should see the Supervisor Snippet Report screen
    When I click on the View link of "Unapproved" snippet in Supervisor Snippet Report
    Then I see the snippet appear in viewer window
    And I see a Approve button in snippet viewer window
    And I see a Reject button in snippet viewer window
    And the Snippets Document view displays "Created By: Monitor Tech (monitortech)"
    And the Snippets Document view displays "On: <timestamp of creation date of pdf>"
    When I click the Reject button in snippet viewer window
    Then I see the Reject Snippet prompt window
    When I click Reject button in reject snippet prompt
    Then I should see the Supervisor Snippet Report screen
    And I query the OperationLog table and validate operation type is "SnippetRejected" for username "super-all"
    And I should see following columns with information: Id, SessionId, ModuleId, UserName, OperationType, SiteId, ExtraContext, Timestamp_UTC
    And I should see following for extraContent column: ReviewedBy, ReviewedAt, CreatedBy, CreatedAt, Asmpid, DocumentId
