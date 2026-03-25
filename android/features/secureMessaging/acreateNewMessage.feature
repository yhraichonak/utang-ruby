@automated @TMS:40320  @messaging @bvt
Feature: Create New Message
  I want view the Secure Messaging
  So that I can make sure I can create a new message

  TestRail Id: C40320

  Scenario: Create A New Message
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "SECURE MESSAGING" on the List
    Then I should see the Messaging screen
    When I click the New Message button
    Then I should see the Choose Contact window
    When I enter "[props.SMC1_LNAME]" into the choose contact edit text
    Then I should see "[props.SMC1_LNAME]" in the choose contact edit text
    When I click on "[props.SMC1_NAME]"
    Then I should see the conversation window
    When I enter "This is an automation test message" in the message field
    And I click the send message button
    Then I should see "This is an automation test message" display in the conversation
