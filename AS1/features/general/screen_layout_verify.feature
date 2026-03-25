@automated @core@general
Feature: Screen layout verify

TestRail Id: C581754
Jira Issues: AS1-3674, AS1-4202
@critical @TMS:581754
#@pre_backup_server_config
#@post_restore_server_config
#@edit_server_config
Scenario: Screen Verify Layout
#Given User restores test environment config.json file from "AS1/list4_config.json"
#And restart WebClient service
#And clear browser cache and reload
And I am a super user with all permissions
When I login to a testSite with a valid credential
Then I should see the patient list screen
And I should see the site listed next to the AS logo

And I should see the "Group / Sort" tab
And the "Group / Sort" tab should be "right" aligned on the screen

And I should see the "Filter Units" tab
And the "Filter Units" tab should be "right" aligned on the screen

And I should see the "Multi-Patient View" tab
And the "Multi-Patient View" tab should be "left" aligned on the screen
