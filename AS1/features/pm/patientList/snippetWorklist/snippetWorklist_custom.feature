@regression @automated @core @pm @pm-patient_list @pm-patient_list-snippet_worklist
Feature: Patient List - Snippet Worklist - Custom
Currently, worklists can only be defined by defining the lists by bed associations (location property on PM census).

Allow the lists to be created by unit also.

The configuration is made via BedList.config which resides in the fed-web bin directory. (Example Below)
The system will now match the values in BedList.config to both a patients unit or bed
<configuration>
  <appSettings>
    <add key="Monitor Tech 1" value="1231,21312" />
    <add key="Monitor Tech 2" value="1231,21312" />
  </appSettings>
</configuration>

NOTE: _____________________________________
Add steps bedlist.config has key "add key='Monitor Tech 1*' value='ICU1'"
And bedlist.config has key "add key='Monitor Tech 2' value='B850'"

_____________________________________

TestRail Id: C316579
Jira Stories: MIG-372

Jira Bugs/Defects: AS1-5714
  @TMS:316579
Scenario: Snippet Worklist Layout
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Monitor Tech 1" on the List
  Then I should see the snippet worklist screen
  And I should see PM patient information in site snippet worklist
  | patientName       | MRN           | location | bed    |
  | NESBITT, ESRON    | 199999        | ICU1     | B850   |
  And I should see the first Unit shift header as active-blue on snippet worklist
  And I should see Unit and Time in shift header on snippet worklist
  And I should see Unit Label in shift header on snippet worklist
  And I should see the Filter Units link disabled
  And I should see the Group Sort link disabled
  #(AS1-5714)
  And I should see the Multi-Patient View link disabled
  And I should see patients with documented and undocumented indicators

  When I click on a undocumented snippet in worklist
  Then I should see the Snippet Tool screen
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View

  When I click the Save button on Snippet Document Edit screen
  Then I see Snippet Saved notification window
  When I click OK button Snippet Saved notification window
  Then I should see the snippet worklist screen

  When I click "Monitor Tech 2" on the List
  Then I should see the snippet worklist screen
  And I should see PM patient information in site snippet worklist
  | patientName       | MRN           | location | bed    |
  | NESBITT, ESRON    | 199999        | ICU1     | B850   |
  And I should see the first Unit shift header as active-blue on snippet worklist
  And I should see Unit and Time in shift header on snippet worklist
  And I should see Unit Label in shift header on snippet worklist
  And I should see the Filter Units link disabled
  And I should see the Group Sort link disabled
  And I should see the Multi-Patient View link disabled
  And I should see patients with documented and undocumented indicators

  When I click on a undocumented snippet in worklist
  Then I should see the Snippet Tool screen
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View

  When I click the Save button on Snippet Document Edit screen
  Then I see Snippet Saved notification window
  When I click OK button Snippet Saved notification window
  Then I should see the snippet worklist screen
