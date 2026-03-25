@utility  @setup  @skip
Feature: Prepare test environment for AT execution

  Scenario: Clear DB
    Given API: Clear ATC DB

  Scenario: Deploy default flight plan
    Given The default flight plan is configured in ATC

#  Scenario Outline: Deploy all flight plans
#    Given User executes test from "ACMS/testdata/configs/<tc_num>.json" file in ATC Integration Test Console if FP "FlightPlan1_<tc_num>" not present
#    Examples:
#      | tc_num |
#      | tc01a  |
#      | tc01b  |
#      | tc02   |
#      | tc03   |
#      | tc04   |
#      | tc05   |
#      | tc06   |
#      | tc07   |
#      | tc08   |
#      | tc09   |
#      | tc11   |
#      | tc12   |
#      | tc13   |
#      | tc14   |
#      | tc15   |
#      | tc20a  |
#      | tc20b  |
#      | tc21a  |
#      | tc21b  |
#      | tc22   |
