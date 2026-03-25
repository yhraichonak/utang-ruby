@regression @events @automated @core  @site35  @pm @pm-events
Feature: PM - Events Layout
  As an utangONE user
  I want to view and select EVENTS and see the event situation 
  So that I can confirm that EVENTS will take me to that Event in time and be properly labeled

*Events Layout*
Event Details should include:
- Event Severity (H, M, L) (use same colors for severity icons as on Monitor tile) _Left Aligned_
- Event Name (e.g. BRADY, ATRIAL FIB, SPO2, etc.) _Left Aligned, after Severity Icon_
- Event time (24 hour format - HH:MM:SS) _Right Aligned_
- Vitals (Discretes) 
-- HR 
-- PVC/min 
-- NBP 
-- SPO2 - 1 
-- SPO2 - 2 
-- SPO2 - 3 
-- SPO2 - 4
-- RR 
-- Temp

Vitals label/field and numeric should display only if received by the source system. If not, nothing should display for that vital.  
When received by the source system, label should display whether or not data is available 

For parameter values:  
{noformat}
- display -- for each value when parameter values are blank or null  
- Display (--) when mean is blank or null
- Display (##) for any mean values when data present  where ## is a number
{noformat}


+Event Grouping/Order+
Events should appear in reverse chronological order.
Event are grouped by/will have the following headers: 
- Last Hour
- 1-6 Hours Ago
- More than 6 hours ago
- MM/DD/YYYY grouping, with leading zeroes, one header per day for events+24h in the past

Event Groupings will be displayed left to right.  User can see additional groups by scrolling (Design TBD - horizontal scroll vs paging)

TestRail Id: C264256

Jira Epic: AS1-114

Jira Stories: MIG-154, AS1-1944

Jira Bugs/Defects: MIG-343, AS1-543, AS1-1170, AS1-1882, AS1-3029, AS1-4574, AS1-4608, AS1-5774, AS1-8002
@critical @TMS:264256
Scenario: PM - Events layout
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on "[props.AP_FULL_NAME]" in patient list
  Then I should see the patient summary screen
  
  When I click on the Monitor tile
  Then I should see the Live Monitor screen

  When I click the "Events" button in sub navigation menu
  Then I should see the Events screen
  And I should see the date display in the more than six hours ago section
  And I should see the "last hour" header on the event screen
  And I should see the "one to six" header on the event screen
  And I should see the "more than six" header on the event screen
  And I should see the "last hour" expand link on the event screen
  And I should see the "one to six" expand link on the event screen
  And I should see the "more than six" expand link on the event screen

  When I click the expand link for the "last hour" section
  And I should see the event title and time stamp with format "%H:%M:%S" in the "last hour" section
  And the time stamp with format "%H:%M:%S" be sorted descending in the "last hour" section
  And I should see the event discretes HR PVC RR in the "last hour" section

  When I click the expand link for the "one to six" section
  And I should see the event title and time stamp with format "%H:%M:%S" in the "one to six" section
  And I should see the event discretes HR PVC RR in the "one to six" section

  When I click the expand link for the "more than six" section
  And I should see the event title and time stamp with format "%H:%M:%S" in the "more than six" section
  And I should see the event discretes HR PVC RR in the "more than six" section

  When I click on the first Event in event section
  Then I should see the Historical Monitor screen
  And I should see the Monitor tab active in sub nav
  
  When I click the "Events" button in sub navigation menu
  Then I should see the Events screen
  
  And I should see the date display in the more than six hours ago section
  And I should see the "last hour" header on the event screen
  And I should see the "one to six" header on the event screen
  And I should see the "more than six" header on the event screen
  And I should see the "last hour" expand link on the event screen
  And I should see the "one to six" expand link on the event screen
  And I should see the "more than six" expand link on the event screen