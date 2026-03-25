@regression @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Monitor Tool - Measure Control - qrsProcessor true

Description (TESTING PURPORES ONLY)
There is a new FED layer based API that can be used to perform a PQRST calculation on a single lead.
The latest web client needs to have the ability to use either the built in javascript base algorithm (this is the default) or be able to switch to use the FED API based algorithm.  This switch over will be controled by a flag in the config.json file.

The API Contract between the FED and the algorithm is still in a state of flux.  A basic implementation has been completed and is ready to be tested on.

Shane Powell will augment the "simulator" environment to be able to use the fed-deployed algorithm created by Dan Bowen.  Once this is deployed, the web-client can begin tying into this new api.

The QRSProcessor takes a basic "post" model with some raw wave data.
The query parameters inform the processor what sort of "answers" are needed.
The ecgWave field in the post body is an array of numbers that represents a single wave form.
The length of this array can be any amount of values.  Currently, the processor performs best when given at least 3 seconds.
The response from the processor is a model that contains "array index" values.
eg.. if the processor is asked to find all R values, the response will include an array of indexes wthin the original wave array that the various R values can be found.

The processor can be asked to

identify all R locations.

identify no R location.

identify the closest R location to a specific "index"

identify all QRS locations.

identify no QRS locations.

identify the closest QRS locations to a specific "index"

Syntax:
Method: POST

update  Path has changed.
old-> Uri: /api/qrsprocessor?qrs={all|none|{center-index-number}&r=={all|none|{center-index-number}}

new-> /api/services/acwa/post/qrsprocessor

POST http://<host>:<port>/api/qrsprocessor?qrs=all&r=1000

TestRail Id: C329229
Jira Stories: AS1-1394
  @TMS:329229
Scenario: PM - Monitor Tool - Measure Control - qrsProcessor true
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
  And I should see the Measure button "inactive"
  And I should see the HR legend in waveform chart
  And I zoom to "5" on snippet tool screen
  When I click on Measure button
  Then I should see the Measure button "active"
  And I should see the HR legend in waveform chart
  And I should see calculating distances of PR, QRS, and QT values
  And I should see calculating distances of QTc value
  And I should see the Measure controls for P, Q/R, S, T
