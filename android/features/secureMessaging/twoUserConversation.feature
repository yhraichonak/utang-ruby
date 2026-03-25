@automated @TMS:40323  @messaging @bvt
Feature: Two User Conversation
  I want view the Secure Messaging
  So that I can make sure I can send messages between two users

  TestRail Id: C40323

  Scenario: Two User Conversation
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "SECURE MESSAGING" on the List
    Then I should see the Messaging screen
    When I select "[props.SMC1_NAME]" from the conversation list
    Then I should see the conversation window
    When I enter "This is an automation test message for " in the message field for "[props.SMC1_FNAME]"
    And I click the send message button
    Then I should see "This is an automation test message for " display in the conversation for "[props.SMC1_FNAME]"
    And I click the more options button
    And I click the logout button
    Given I am a user with cardiac fellow permissions
    When I login to a testSite with a valid credential
    And I click the AS1 button
    And I click "SECURE MESSAGING" on the List
    Then I should see the Messaging screen
    When I select "[props.SMC2_NAME]" from the conversation list
    Then I should see the conversation window
    Then I should see "This is an automation test message for " display in the conversation for "[props.SMC1_FNAME]"
    When I enter "Thank you I received your message" in the message field
    And I click the send message button
    Then I should see "Thank you I received your message" display in the conversation
