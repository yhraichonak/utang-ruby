@regression @automated @core @cardio @cardio-patient_list
Feature: Patient List - Most Recent
  Patient Cell Layout
  Each patient cell contains the following information:
  Patient Name (e.g. "Last, First"), Most recent ECG Acquisition Date/Time (e.g. "12/07/10 - 21:16:03"), Gender, Age, and a counter of ECGs associated with that patient.

  TestRail Id: C179313

  Jira Epic: AS1-28

  Jira Stories: AS1-32, AS1-126

  Jira Bugs/Defects: AS1-2878, AS1-2879, AS1-3224, AS1-4792, AS1-6612, AS1-6634

  @critical @TMS:179313
  Scenario: Patient List - Most Recent
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "MOST RECENT" on the List
    Then I should see the patient list screen
    And I should be on "MOST RECENT" patientList
    And I should see patient information in patientList
      | patientName    | gender | age | acqDate               | ecgCount | diagStatement       |
      | Nesbitt, Esron | F      | 18  | 08/28/2020 - 11:44:59 | 3        | Normal sinus rhythm |
    And I should see patient list sorted by acquistion date by LIFO
    When I click on "Nesbitt, Esron" in patient list
    Then I should see the ECG 12 lead screen
    When I click the Back button in patient header
    Then I should see the patient list screen
    And I should be on "MOST RECENT" patientList
    And I should see no patient search in header
    When I click on "Nesbitt, Esron" in patient list
    Then I should see the ECG 12 lead screen
    And I click on the ECG tile
    When I click on the info icon on the ecg toolbar
    And I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
    When I click the Back button in patient header
    Then I should see the patient list screen
    And I should be on "MOST RECENT" patientList

#Scenario: Patient Lists - Navigate to Most Recent While Loading in Progress
#  When I navigate to http://asttesthost01/site34/rc/
#  And I open Developer Tools
#  And I click the “Performance” tab
#  And I click "Slow 3G" for Network option
#  And I login to the test site with "utang" and "XXXXX"
#  Then I should see the PM Census List
#  And I should see the PM Census list loading
#  When I click the “Most Recent” list while the PM Census is still loading
#  Then I should see the Most Recent list display (AS1-4792)