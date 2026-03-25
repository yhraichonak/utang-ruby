@regression @monitor @nodeSim @automated @core @pm @pm-monitor
Feature: PM - Minimum Resolution
The web application will dynamically resize until a minimum resolution of 1280x720

*Note: There is a current PM customer utilizing a viewport of 900x580 for PM. Consideration should be made for the PM module to be
flexible enough to handle this small resolution while allowing PM to remain usable for the customer.


TestRail Id: C264292
Jira Issues: AS1-419, AS1-2246, AS1-2931
  @TMS:264292
Scenario: PM - Minimum Resolution
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When reset unit filtering
  When I click "Census" on the List
  Then I should see the patient list screen
  When I see the browser resolution to "900" width by "600" height
  When I click on default patient in list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I click the expand icon menu button
  Then I should see the expanded navigation links
  When I click the expand icon menu button
  Then I should not see the expanded navigation links
  And I should see the Live Monitor time in "[props.COMMON_DATE_FORMAT]" format
  And the "Live" button is active
  When I click the "Live" button in sub navigation menu expecting button inactive
  And the "Live" button is inactive
  And the Monitor Time Ago displays on monitor
  When I click the "Live" button in sub navigation menu
  And the "Live" button is active
