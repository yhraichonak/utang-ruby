@list
Feature: Custom List Endpoint

  Scenario: User is able to get Custom List  data
    Given I login to the api with a valid credential
    When user executes aso/lists GET request for test site
    Then system should return custom list "AT_list"