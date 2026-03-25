@regression @manual @automated @c3po
Feature: C3PO links - Cardio
  TestRail Id: C328796
  Jira Epic: AS1-258
  Jira Stories: AS1-1190

  We need to include the site id in our GetEcgByAcquisitionDateTime request in the c3p0 ECG strategy.

  Request is: GetEcgByAcquisitionDateTime(string asmpid, string acquisitiondate,string acquisitiontime,
  string siteid, string sessionid = "", string adusername = "")

  We need to be able to capture the ecgId and asmpid from the payload. If they are not present we
  continue with the current workflow. If the asmpid value is empty or missing from the payload we
  will use the mrn from the payload to search for the asmpid from the mpid service. Both cannot be
  empty or missing from the payload.

  If the ecgid value is empty or missing from the payload we will hit the cardio service for the ecgid.

  Create a new path for c3p0 to allow for default cardio instances if the partner key is new.

  ex.links: ECG(mrn) -
  http://site34.dev-host-03.utangtech.com/develop/#/api/sharelink/epic/ecg?siteid=1763&
  payload=MDRUMTU6NDU6NDYuNzYzWqrkhdIrIEMgQvxqz3Uyjzhfh4U%2FsdEdJVWNKi7gYU2zTB9efoK3mnv2Uaf
  Hf7EGkYYUZrIHwjUIk6mH%2Bb1Bd20oaGIggu6dM2OZaDIQGA3%2B

  ECG(ecgID) -
  http://site34.dev-host-03.utangtech.com/develop/#/api/sharelink/epic/ecg?siteid=1763&
  payload=MDRUMTU6NDc6MzYuMjQ2WrYiindpK5x2REa7SoFi5aRqUfEBDsNowoPS94iT2lFn6zkxbaN7hyUi6IIy
  wn4V%2BMRynAd%2Bk3d03Doxuy6RChTin0Z%2FkrgxeAEv8Wt9xKnk
 @critical @TMS:328796
  Scenario: Cardio C3P0 Launch - ECG(mrn)
    Given I open C3PO URL generation interface
    And I generate ecg epic C3PO url with query TEST=1234567890&ad=username&mrn=91334&time=2022-09-29T11:54:41-05:00
    And I navigate to the generated C3PO url
    Then I should see the ecg list on ECG screen
    And I should see the ecg list close automatically
    When I click on the info icon on the ecg toolbar
    Then the ecg detailed info drawer displays
    When I click on the info icon on the ecg toolbar
    Then I should see the 12 waveforms rhythm strips I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 V3R V4R V7 waveforms display
    And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead
    And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead
    And I should see V.HR and A.HR labels in ECG Details Header are right aligned

  Scenario: Cardio C3P0 Launch - ECG(ecgID)
    Given I open C3PO URL generation interface
    And I generate ecg epic C3PO url with query TEST=1234567890&ad=username&ecgid=237&asmpid=416cd2c9-ef0d-4570-860b-ca82f37bfcc3
    And I navigate to the generated C3PO url
    Then I should see the ecg list on ECG screen
    And I should see the ecg list close automatically
    When I click on the info icon on the ecg toolbar
    Then the ecg detailed info drawer displays
    When I click on the info icon on the ecg toolbar
    Then I should see the 12 waveforms rhythm strips I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 V3R V4R V7 waveforms display
    And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead
    And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead
    And I should see V.HR and A.HR labels in ECG Details Header are right aligned
