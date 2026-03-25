@utility  @edit_server_config @setup @skip
Feature: Prepare test environment for AT execution

  Scenario Outline: Prepare test users My Patients
    When I login to a testSite with username "<username>" and password "<password>"
    And User have at least 40 patients in My Patients List
    Examples:
      | username             | password             |
      | [props.SU1_USERNAME] | [props.SU1_PASSWORD] |
      | [props.SU2_USERNAME] | [props.SU2_PASSWORD] |
      | [props.SU3_USERNAME] | [props.SU3_PASSWORD] |
      | [props.SU_USERNAME]  | [props.SU_PASSWORD]  |
      | [props.U_USERNAME]   | [props.U_PASSWORD]   |
      | [props.NU_USERNAME]   | [props.NU_PASSWORD]   |
#
  Scenario: Restore default config
    Given User restores test environment config.json file from "AS1/default_config.json"
