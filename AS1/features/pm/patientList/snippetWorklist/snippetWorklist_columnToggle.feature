@regression @automated @core @pm @pm-patient_list @pm-patient_list-snippet_worklist
Feature: Patient List - Snippet Worklist Column Toggle
Feature request:

For worklists in web, the grouping of patient cells of >1 per line is not the best organization of patients for a worklist item
(users go "down" the list, checking off items one-by one). They would like one patient per line (even though this means unused space).

Possible solution: Provide a preference toggle for grouping of worklists (e.g. single column/multiple columns)

Update 4/30/19-
Default = Single Column ON 
The user selection will persist across sessions

TestRail Id: C328784

Jira Epic: AS1-2542

Jira Stories: AS1-1615

Jira Bugs/Defects: AS1-1663, AS1-5888, AS1-8005
@critical @TMS:328784
Scenario: Snippet Worklist Column Toggle
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Monitor Tech 1" on the List
  Then I should see the snippet worklist screen
  And I should see single column toggle turned "On"
  And I should see snippet worklist with single columns "On"
  And I should see PM patient information in site snippet worklist
  | patientName       | MRN           | location | bed    |
  | NESBITT, ESRON    | 199999        | ICU1     | B850   |
  And I should see the first Unit shift header as active-blue on snippet worklist
  And I should see Unit and Time in shift header on snippet worklist
  And I should see Unit Label in shift header on snippet worklist
  And I should see the Filter Units link disabled
  And I should see the Group Sort link disabled
  And I should see patients with documented and undocumented indicators

  When I click on single column toggle
  And I should see single column toggle turned "Off"
  And I should see snippet worklist with single columns "Off"  
  And I should see the first Unit shift header as active-blue on snippet worklist
  And I should see Unit and Time in shift header on snippet worklist
  And I should see Unit Label in shift header on snippet worklist
  And I should see the Filter Units link disabled
  And I should see the Group Sort link disabled
  And I should see patients with documented and undocumented indicators
  
  When I click "Monitor Tech 2" on the List
  Then I should see the snippet worklist screen
  And I should see single column toggle turned "Off"
  And I should see snippet worklist with single columns "Off"
  And I should see PM patient information in site snippet worklist
  | patientName       | MRN           | location | bed    |
  | NESBITT, ESRON    | 199999        | ICU1     | B850   |
  And I should see the first Unit shift header as active-blue on snippet worklist
  And I should see Unit and Time in shift header on snippet worklist
  And I should see Unit Label in shift header on snippet worklist
  And I should see the Filter Units link disabled
  And I should see the Group Sort link disabled
  And I should see patients with documented and undocumented indicators
  
  When I click on single column toggle
  And I should see single column toggle turned "On"
  And I should see snippet worklist with single columns "On"
  And I should see PM patient information in site snippet worklist
  | patientName       | MRN           | location | bed    |
  | NESBITT, ESRON    | 199999        | ICU1     | B850   |
  And I should see the first Unit shift header as active-blue on snippet worklist
  And I should see Unit and Time in shift header on snippet worklist
  And I should see Unit Label in shift header on snippet worklist
  And I should see the Filter Units link disabled
  And I should see the Group Sort link disabled
  And I should see patients with documented and undocumented indicators
  
  When I click on single column toggle
  And I should see single column toggle turned "Off"
  And I should see snippet worklist with single columns "Off"  
  And I should see the first Unit shift header as active-blue on snippet worklist
  And I should see Unit and Time in shift header on snippet worklist
  And I should see Unit Label in shift header on snippet worklist
  And I should see the Filter Units link disabled
  And I should see the Group Sort link disabled
  And I should see patients with documented and undocumented indicators
  
  When I click the username dropdown indicator
  Then I should see About and Logout links  
  When I click on Logout link
  Then I should see the login screen
  
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Monitor Tech 1" on the List
  Then I should see the snippet worklist screen
  And I should see single column toggle turned "Off"
  And I should see snippet worklist with single columns "Off"
  And I should see PM patient information in site snippet worklist
  | patientName       | MRN           | location | bed    |
  | NESBITT, ESRON    | 199999        | ICU1     | B850   |
  And I should see the first Unit shift header as active-blue on snippet worklist
  And I should see Unit and Time in shift header on snippet worklist
  And I should see Unit Label in shift header on snippet worklist
  And I should see the Filter Units link disabled
  And I should see the Group Sort link disabled
  And I should see patients with documented and undocumented indicators
  
  When I click on single column toggle
  And I should see single column toggle turned "On"
  And I should see snippet worklist with single columns "On"
  And I should see PM patient information in site snippet worklist
  | patientName       | MRN           | location | bed    |
  | NESBITT, ESRON    | 199999        | ICU1     | B850   |
  And I should see the first Unit shift header as active-blue on snippet worklist
  And I should see Unit and Time in shift header on snippet worklist
  And I should see Unit Label in shift header on snippet worklist
  And I should see the Filter Units link disabled
  And I should see the Group Sort link disabled
  And I should see patients with documented and undocumented indicators
  When I click the browser refresh button
  And I should see single column toggle turned "On"

  When I click on single column toggle
  And I should see single column toggle turned "Off"

  When I click the browser refresh button
  And I should see single column toggle turned "Off"
  
  
  
  