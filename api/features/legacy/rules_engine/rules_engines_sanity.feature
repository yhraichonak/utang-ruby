@sanity
Feature: RULES ENGINE API Sanity

Scenario: Rules Engine Sanity Check
Then it should login to the api
Then it should create and view "location_one" for "Automation Site"
Then it should get locations for site "Automation Site"
Then it should create and view by name "location_two" and site "Automation Site"
Then it should create "location_three" for "Automation Site" then update to "location_thirty_three"
Then it should create and delete "location_four" for "Automation Site"

Then it should get all enterprise user groups
Then it should get enterprise user group by id
Then it should create and view new enterprise group "group_one" and site "Automation Site"
Then it should create and update new enterprise group "group_two" and site "Automation Site"
Then it should create and delete new enterprise group "group_three" and site "Automation Site"

Then it should get all notification rules
Then it should get the first notification rules by id
Then it should create and view new notification rule "notification_rule_one" for site "Automation Site"