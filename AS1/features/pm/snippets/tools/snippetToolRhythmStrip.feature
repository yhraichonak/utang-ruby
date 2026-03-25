@regression @nodeSim @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Snippet Tool Rhythm Strip
Rhythm Strip
On the Monitor Tool, display a zoomed- out portion of the waveform that is being viewed by the user. The rhythm strip should display the waveform vertically centered based on highest and lowest waveform values.

the rhythm strip should best effort display both selected waveforms (minimum both leads on rhythm strip, zoom view when possible)
If Dual Lead flag is FALSE, center the singular waveform vertically in the rhythm strip.
*Note: Worst Case Scenario is standard ECG II/ECG V1 waveform (top lead points up and bottom lead points down) ,user should be able to tell there are two waveforms in the view.

The rhythm strip should:

Include a location preview (colored green in mocks)
green for highlighted portion (being the portion of the wave that is presented in the zoom view)
white for non-highlighted portion (being the portion of the wave that is not viewed in the zoom view)
Have a right-justified time indicator HH:MM:SS 24h format which displays the time of the right-most visible portion of the rhythm strip.


TestRail Id: C264266
Jira Stories: AS1-133, AS1-1698, AS1-1940, AS1-3447
@critical @TMS:264266
Scenario: PM - Snippet Tool Rhythm Strip
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
	Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on default patient in list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  And I see the Snippet Rhythm Strip timestamp "%H:%M:%S" format

  When I zoom "out" on snippet tool screen
  Then the snippet tool zoom value is set at "1"

   Then User is able to select every waveform in option 1 dropdown on Snippet screen
   And User is able to select every waveform in option 2 dropdown on Snippet screen
   And User is able to select "6 seconds" snippet duration on Snippet screen
   And User is able to select "30 seconds" snippet duration on Snippet screen
   And User is able to select "120 seconds" snippet duration on Snippet screen
