@automated @TMS:40332  @regression @bvt
Feature: General Tile Behavior
  As an AS1 user
  I want to be able to validate the different tile behaviors

  TestRail Id: C40332

  Scenario: Verify patient summary tiles are the same height
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    And I click the AS1 button
    Then I should see my ListOfList window
    When I click "Census" in List of List menu
    Then I should see the patient List
    When I click on the first person in the Most Recent List
    Then I should see the Live Monitor screen
    And I click the Home button
    Then I should see the tiles are the same size

#  Scenario: Tile behavior for No Data
#    When I access a patient from a patient list
#    Then the patient's summary screen will display
#    And I should validate that if no data displays for a tile (Allergies, Care Team, Dx/Problems, ECGs, Monitor, Docs, Demographics, Labs, Vitals, Meds, Images)
#    And I click on one of the tiles
#    Then the tile still remains active and opens
#  NOTE: Images will still launch RES Md and user will have to go back to utang

#  Scenario: Time range for tile data
#    When I access a patient from a patient list
#    Then the patient's summary screen will display
#    When the time is less than 48 hours
#    Then the format will display as "##h"
#    When the time is more than 48 hours
#    Then the format will display as "#d #h"
