@automated @TMS:40322  @messaging @bvt
Feature: Verify Contact List
  I want view the Secure Messaging
  So that I can make sure I can view my contact list

  TestRail Id: C40322

  Scenario: Contact List Verification
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "SECURE MESSAGING" on the List
    Then I should see the Messaging screen
    When I click the New Message button
    Then I should see the Choose Contact window
