@regression @automated @core @pm @pm-patient_list @pm-patient_list-features
Feature: PM - Patient List - Group-Sort

  For the PM patient list, Users should have the ability to 1st group any item in the patient cell then sort by any item in the patient cell then sort again any item in the patient cell. User should also be able to change the default sort (ascending or descending) of the group, the secondary sort and the tertiary sort.

  Patient Cells Include:
  Patient Monitoring - Name (Last/First or First/Last), Gender, DOB, MRN, Unit, Bed, Active/inactive flag

  Secondary sort should trump tertiary sort.

  For example: *note:* Example is OB data
  Group - Unit - Ascending
  Patient Last Name – Ascending
  Ge - Descending

  Units= Dane, John  - Dodge, Jane
  Patients (Last Name) = Smith, Sally - Sloan, Abigail - Smith, Sally - Thompson, Jennifer
  Dilation - White (0.2-1.4) - Yellow (1.8-2.5) - Yellow (1.8-2.5) - White (0.2-1.4)

  {Header} Dodge, Jane
  Smith, Sally (Yellow)
  Smith, Sally (White)
  Thompson, Jennifer (White)

  Not:
  {Header} Dodge, Jane
  Smith, Sally (White)
  Thompson, Jennifer (White)
  Smith, Sally (Yellow)

  The existing unit "Filter" feature should remain in tact. If a filter is in place the group/sort should only look at that filtered patient list.
  There should be an option to group by "None". For example, if a User just want to see a list of patients by a filtered unit list of 2 out of 3 units sorted by dilatation.
  The group and sort should be dismissed in a single action and should a similar action across all three client platforms.
  Any primary, secondary or tertiary Group/Sort chosen by the User should be stored locally (no PHI stored) on the client and used each time the user logs in, until the user changes or removes the Group/Sort.
  This control should be a pop-up style. It should show both Group, Sort(s) and Filters. Filter should be listed second. Users should have the option to sort ascending or  descending.

  Default Patient Cell Data Default Sort
  Active/Inactive Flag - Active patients 1st, then inactive
  Bed - Ascending
  DOB - Ascending (by year)
  First/Last - Ascending
  Gender - Ascending
  Last/First - Ascending
  MRN - Ascending
  Nurse - Ascending
  Physician - Ascending
  Room - Ascending
  Unit - Ascending

  Headers should reflect the sort. For example:
  if Grouped by Unit, then use "Unit" label for header
  if Grouped by Active/Inactive, then use "Active" or "Inactive" as the header label

  Need to represent the Default Sort in this Control. How to deal with PM Server-side sort settings? Are they deprecated?

  Need a way to clear/restore default. This should be consistent across all platforms.

TestRail Id: C264245

Jira Epic: AS1-2521

Jira Stories: AS1-120, AS1-448, AS1-672, AS1-3674

Jira Bugs/Defects: AS1-1991, AS1-3028, AS1-4650, AS1-5962, AS1-6046
@critical @TMS:264245
@failed
#  TODO: identify Jira issue id for improper  sorting in Dates and MRN
#  https://teams.microsoft.com/l/message/19:a2d8614990904f40a893baa10e4782da@thread.skype/1675372333058?tenantId=5118370c-9c55-4e71-9afe-9bea1e8a7ffd&groupId=28bbefff-af2d-4647-b55d-dd5addacf62b&parentMessageId=1675372333058&teamName=Testing&channelName=General&createdTime=1675372333058&allowXTenantAccess=false
Scenario: PM Patient List Group-Sort
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen

  #And I should see Group/Sort is right aligned

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click the reset button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link not highlighted
  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted
  And it should be sorted by Last Name in ascending order


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted
  And it should be sorted by First Name in ascending order


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted
  And it should be sorted by Gender in ascending order


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted
  #TODO: tempaorarily comment to reduce noise for knonw issues
  #And it should be sorted by DOB in ascending order


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted
  And it should be sorted by MRN in ascending order


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted
  And it should be sorted by Active Inactive in ascending order


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "None"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted
  # And it should be sorted by Unit in ascending order


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "None"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "Unit"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "Last Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "First Name"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted


  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "Gender"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "Age"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "DOB"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "MRN"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "Bed"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "None"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Unit"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Last Name"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "First Name"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Gender"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Age"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "DOB"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "MRN"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Bed"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click on Group By dropdown and select "Active Inactive"
  When I click on first Sort By dropdown and select "Active Inactive"
  When I click on second Sort By dropdown and select "Unit"
  And I click the ok button on Group / Sort window
  Then I should see the patient list screen
  And I should see the Group Sort link highlighted

  When I click on Group/Sort link
  Then I should see the Group/Sort window
  When I click the reset button on Group / Sort window
  Then I should see the Group Sort link not highlighted
