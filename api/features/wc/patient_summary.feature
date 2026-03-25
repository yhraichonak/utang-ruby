@patientsummary
Feature: Patient list Endpoint

  Scenario: User is able to get Patient Summary  data
    Given I login to the api with a valid credential
    When user executes patient/summary GET request with query params "asmpid=[props.DP_ASMPID]"
    Then system should return patient summary
    """
{
  "..demographics..label[0]":"Patient Name",  "..demographics..value[0]":"matches:([props.DP_LNAME],[props.DP_FNAME]|[props.DP_FULL_NAME])",
  "..demographics..label[1]":"matches:(MRN|DOB|Gender|Age)",  "..demographics..value[1]":"[props.DP_MRN]",
  "..demographics..label[2]":"DOB",  "..demographics..value[2]":"[props.DP_DOB_SHORT]",
  "..demographics..label[3]":"Gender",  "..demographics..value[3]":"[props.DP_SEX_FULL]",
  "..demographics..label[4]":"Age",  "..demographics..value[4]":"[props.DP_AGE]",
  "..monitor..model..status":"matches:(inactive|active)",    "..monitor..model..hours":"matches:(72|192)",  "..monitor..model..count":"matches:\d*",
  "..ecgs..model..icon":"ic_ecg",    "..ecgs..model..count":"15",  "..ecgs..model..firstEcgId":"223"
}
"""


