@sanity
Feature: SECURE MESSAGING API Sanity
 
Scenario: Secure Messaging Sanity Check
Then it should login to the api as user "super-all" with password "XXXXX"
Then it should return the contact list
Then it should return the conversation list
Then it should return the conversation by contact id
Then it should return the conversation by conversation id
Then it should send a message
Then it should return the new message in the conversation