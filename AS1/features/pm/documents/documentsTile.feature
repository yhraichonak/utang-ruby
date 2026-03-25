@regression @documents @automated @core @pm @pm-documents
Feature: PM - Snippet Rhythms Documents Tile

Description
Current implementation of the Snippets (Rhythms) tile is a REPLACEMENT of the documents tile. The user can either see a Documents Tile from the EMR or a Snippets (Rhythms) tile.  As of 3.1 no client work has been done and the Rhythms tile displays the proper content as listed below, but header displays as "Documents"

Tile Layout
Header:

In the header, left-most is a Tile icon for Rhythms (like documents)

Tile Header = "Documents"  (left aligned)

Count (right justified) when there are more Rhythms than are displayed on the Summary tile

Content:
2 column-layout of Snippets and their creation date

First column contains the Event Description, left aligned (truncated if necessary)

Second column displays the Document Date,right aligned, in format 02/15/16 (cannot be truncated)

Most recent documents are shown LIFO (last in, first out)

Interaction
Tapping on the tile opens the Expanded Snippets (Rhythms) for the selected patient


TestRail Id: C328903
Jira Stories: AS1-1996, AS1-1997, AS1-2215, AS1-2001, AS1-2146, AS1-2750, AS1-2656
@critical @TMS:328903
Scenario: PM - Snippet Rhythms Documents Tile
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on default patient in list
  Then I should see the patient summary screen
  And I should see the patient document tile
  And I should see the document tile with a count of documents
  And I should see patient snippet descriptions and date of snippet created
  And I should see the snippet descriptions not wrap and truncate when necessary
  When I click on the document tile
  Then I should see the Snippets Rhythms Documents screen
  And I should see No Documents message and No Documents selected
