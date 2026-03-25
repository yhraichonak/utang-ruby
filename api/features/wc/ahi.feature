@ahi
Feature: Snippet Event Description Endpoint

  Scenario: User is able to get resources alt text
    Then User is able to login into the system with valid credentials
     When user executes services/ahi/resource/alltext GET request
   Then system should return data
    """
{

"..id[0]":"0","..text[0]":"AHI-PI No Data","..algorithm[0]":"AHI-PI","..status[0]":"No Data","..type[0]":"Future Risk",
"..description[0]":"contains:There is insufficient data available to produce an AHI-PI Indicator at this time. The first AHI-PI indicator may take several minutes to appear",

"..id[1]":"1","..text[1]":"AHI-PI Low Risk","..algorithm[1]":"AHI-PI","..status[1]":"Low Risk","..type[1]":"Future Risk",
"..description[1]":"contains:Updated every 2 minutes, AHI-Predictive Indicator (AHI-PI) is an analytic produced by AHI System that predicts the likelihood of an adult (18+) patient experiencing",

"..id[2]":"2","..text[2]":"AHI-PI Moderate Risk","..algorithm[2]":"AHI-PI","..status[2]":"Moderate Risk","..type[2]":"Future Risk",
"..description[2]":"contains:Updated every 2 minutes, AHI-Predictive Indicator (AHI-PI) is an analytic produced by AHI System that predicts the likelihood of an adult (18+) patient experiencing",

"..id[3]":"3","..text[3]":"AHI-PI High Risk","..algorithm[3]":"AHI-PI","..status[3]":"High Risk","..type[3]":"Future Risk",
"..description[3]":"contains:Updated every 2 minutes, AHI-Predictive Indicator (AHI-PI) is an analytic produced by AHI System that predicts the likelihood of an adult (18+) patient experiencing",

"..id[4]":"4","..text[4]":"AHI-PI Not Indicated","..algorithm[4]":"AHI-PI","..status[4]":"Not Indicated","..type[4]":"Future Risk",
"..description[4]":"contains:AHI-PI monitoring is unavailable. One or more of the following contraindications apply:",

"..id[5]":"5","..text[5]":"AHI-PI Not Subscribed","..algorithm[5]":"AHI-PI","..status[5]":"Not Subscribed","..type[5]":"Future Risk",
"..description[5]":"contains:AHI-PI monitoring is unavailable. No AHI-PI license found for this ECG monitor."
}
"""


  Scenario: User is able to get AHI analysis result
    Then User is able to login into the system with valid credentials
    When user executes services/ahi/AnalysisResult/[props.DP_ASMPID_AHI] GET request
    Then system should return data
    """
{}
"""