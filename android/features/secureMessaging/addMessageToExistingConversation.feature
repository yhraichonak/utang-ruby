@automated @TMS:40321  @messaging @bvt
Feature: Add Message To Existing Conversation
  I want view the Secure Messaging
  So that I can make sure I can view secure messaging

  TestRail Id: C40321

  Scenario: Add Message To Existing Conversation
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "SECURE MESSAGING" on the List
    Then I should see the Messaging screen
    When I select the first user from the Messaging screen
    Then I should see the conversation window
    And I should see the user conversation screen
    When I enter "This is an automation test message" in the message field
    And I click the send message button
    Then I should see "This is an automation test message" display in the conversation
