@automated @TMS:158831  @general @regression
Feature: Login with a User with Valid Vendor Credentials
  As an AS1 user
  I should not be able to login to the site with valid vendor credentials

  TestRail Id: C158831


  Scenario: Valid Vendor Credentials
    Given I have AS1 running with appium
    And I click the more options button then the Logout button
    Then I should see the Site List screen
    When I click the more options button then the About button
    And I register devices with global services
    And I click the OK button on the About window
    When I click "Automation Site" button on Site List screen
#    And I clear vendor credential password in AMP
    Then I login with username "[props.DU_USERNAME]" and "[props.DU_PASSWORD]" password
#    Then Vendor login screen displays
#    And I should complete the vendor login
    And I should see the patient List

    # Note: Steps are commented out until the api call to change vendor credentials is figured out
