@automated @poc @el @critical @atc_importer
@EPIC:Importer @skip
Feature: POC ATC Importer

  @clear_atc_flights
  Scenario: ATC Importer - All commands
    Given User executes test from "[props.CONFIGS_TC01A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And User executes Export command via ATC Excel Importer
    And User executes Import command via ATC Excel Importer for file "ACMS/testdata/TestImport01.xlsx"
    And User executes Validate command via ATC Excel Importer
    And User verifies output for Validate command via ATC Excel Importer for file "ACMS/testdata/TestImport01Broken.xlsx"
  """
  .*Facility name does not match saved facilities in row 3.*
  """
     And User executes "Clear Database" command via ATC Excel Importer

  Scenario: ATC Importer - compare excel files - with filters
    Given User executes test from "[props.CONFIGS_TC01A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And User executes Export command via ATC Excel Importer
    And User compares downloaded xlsx-file with expected "ACMS/testdata/configs/tc01a.xlsx" ignoring
    """
    [
      "cell_match:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}",
      "column_match:.*Leave blank.*"
    ]
    """


  Scenario Outline: ATC Importer - compare with multiple excel files
    Given User executes test from "[props.CONFIGS_TC01A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And User executes Export command via ATC Excel Importer
    And User compares downloaded xlsx-file with one of expected "<testdata_dir>/tc01a.xlsx,<testdata_dir>/tc01av1.xlsx,<testdata_dir>/tc01a_v2.xlsx" ignoring
    """
    [
      "cell_match:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}",
      "column_match:.*Leave blank.*"
    ]
    """
    Examples:
      | testdata_dir          |
      | ACMS/testdata/configs |

  Scenario: ATC Importer - compare excel files - no filters
    Given User executes Export command via ATC Excel Importer
    And User compares downloaded xlsx-file with expected "ACMS/testdata/configs/tc01a.xlsx" ignoring
    """
    []
    """
