@sm
Feature: Secure Messaging Endpoint

  Scenario: User is able to get Secure Messaging contacts
  Given User is logged into the system with valid credentials
  And user sends secure messages "["Hello"]" to user "[props.SMU_FULL_NAME]"
  When user executes aso/contacts/getbysiteid GET request
  Then system should return contact
  """
  {"contactId":"matches:\\d+","name":"[props.DU_FULL_NAME]"}
  """


  Scenario: User is able to get Secure Messaging conversation by recipient contact id - existing
    Given User is logged into the system with valid credentials
    When user executes aso/messaging/conversationid GET request with query params "recipientcontactid=[[props.SMU_FULL_NAME].<contactId>]"
    Then system should return data
    """
    {"existing":"true"}
    """


  Scenario: User is able to post Secure Message
    Given User is logged into the system with valid credentials
    And user sends secure message to user "[props.SMU_FULL_NAME]" with body
    """
    { "messages": ["AT Message 1"]}
    """
    Then verify the last user message to user "[props.SMU_FULL_NAME]" attributes
    """
    {"lastMessageTimeStamp":"matches:[NOW.%Y-%m-%d].*","lastMessage":"AT Message 1"}
    """

  Scenario: User is able to get all Secure Messages
    Given User is logged into the system with valid credentials
    When user executes aso/messaging/conversations GET request
    Then system should return data
    """
{
  "lastMessageTimeStamp":"matches:.*",
  "firstMessageTimeStamp":"matches:.*",
  "conversationId":"matches:\\d+",
  "participant":"matches:.*contactId.*\\d+.*name.*",
  "hasUnreadMessages":"matches:(true|false)",
  "lastMessage":"matches:.*"
}
"""


  Scenario: User is able to get Secure Messaging conversation details
    Given User is logged into the system with valid credentials
    And user sends secure messages "["Message one", "Message two", "Message three"]" to user "[props.SMU_FULL_NAME]"
    When user gets conversation details with user "[props.SMU_FULL_NAME]"
  Then system should return data
    """
{"..model..messages..message[-1]":"Message three",
"..model..messages..message[-2]":"Message two",
"..model..messages..message[-3]":"Message one"}
"""

  Scenario: User is able to get Secure Messaging conversation details with params
    Then User is logged into the system with valid credentials
    And user sends secure messages "["Message one", "Message two", "Message three"]" to user "[props.SMU_FULL_NAME]"
    When user gets conversation details with user "[props.SMU_FULL_NAME]" with query params "frommessageid=[Message one.<messageId>]&count=2"
    Then system should return data
    """
{"..model..messages..message[0]":"Message one",
"..model..messages..message[1]":"Message two"}
"""


  Scenario: User is able to delete conversation
    Then User is logged into the system with valid credentials
    And user sends secure messages "["Message one", "Message two", "Message three"]" to user "[props.SMU_FULL_NAME]"
    When user deletes conversation with user "[props.SMU_FULL_NAME]"
    Then verify conversation with user "[props.SMU_FULL_NAME]" is absent in all conversations list
