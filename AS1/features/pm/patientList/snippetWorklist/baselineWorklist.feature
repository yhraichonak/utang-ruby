@regression @automated @core @pm @pm-patient_list @pm-patient_list-snippet_worklist
Feature: Snippet Baseline Worklist 

TestRail Id: C328942
Jira Stories: AS1-2027, AS1-2028, AS1-2161, AS1-2177, AS1-2898, AS1-2941, AS1-3625
@critical @TMS:328942
Scenario: Snippet Baseline Worklist 
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  And I cleanup baseline worklist snippet in db for mrn "252731"
	Then I should see the patient list screen
  When I click "Snippet Baseline Worklist" on the List
  Then I should see the snippet worklist screen
  And I should see Group Sort, Filter Units links disabled
  And I should see the Multi-Patient View link disabled
  And I should see single column toggle turned "On"
  And I should see snippet worklist with single columns "On"
  And I should see PM patient information in site snippet worklist
    | patientName       | gender | age | MRN        | DOB             | location | bed    | status   | statusColor |
    | Ohm, Georg        | M      | 70  | 252731     | DOB: 07/31/1952 | SU       | SU-06  | active   | blue        |
  And I should see same number of patients in worklist as listed in list of list count
  
  When I click on single column toggle
  And I should see single column toggle turned "Off"
  And I should see snippet worklist with single columns "Off"
  And I should see PM patient information in site snippet worklist
    | patientName       | gender | age | MRN        | DOB             | location | bed    | status   | statusColor |
    | Ohm, Georg        | M      | 70  | 252731     | DOB: 07/31/1952 | SU       | SU-06  | active   | blue        |
  And I should see same number of patients in worklist as listed in list of list count
  
  When I click on single column toggle
  And I should see single column toggle turned "On"
  And I should see snippet worklist with single columns "On"
  And I should see PM patient information in site snippet worklist
    | patientName       | gender | age | MRN        | DOB             | location | bed    | status   | statusColor |
    | Ohm, Georg        | M      | 70  | 252731     | DOB: 07/31/1952 | SU       | SU-06  | active   | blue        |
  And I should see same number of patients in worklist as listed in list of list count




