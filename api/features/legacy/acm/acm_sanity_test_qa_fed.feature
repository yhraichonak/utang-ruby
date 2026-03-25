@sanity   @skip
Feature: ACM FED QA API Sanity

Scenario: ACM FED QA API Sanity Check
  Then it should post the ACM FED QA rules
  Then it should return the ACM FED QA rules
  
  And it should return rule "1" with event label "VTach" and alert text "VTach"
  And it should return rule "1" condition "1" with duration "1" percentage "100" suspension "60" is suppress all "false" facility "Facility X" unit "" bed ""
  And it should return rule "1" condition "2" with duration "1" percentage "100" suspension "60" is suppress all "false" facility "Facility X" unit "ACM" bed ""
  And it should return rule "1" condition "3" with duration "1" percentage "100" suspension "60" is suppress all "false" facility "Facility X" unit "ACM" bed "ACM1"
  And it should return rule "1" condition "4" with duration "5" percentage "3" suspension "12" is suppress all "false" facility "Site-34" unit "ICU1" bed "B850"
    
  And it should return rule "2" with event label "Brady" and alert text "Brady"
  And it should return rule "2" condition "1" with duration "1" percentage "100" suspension "60" is suppress all "false" facility "Facility Y" unit "" bed ""
  
  And it should return rule "3" with event label "Asystole" and alert text "Asystole"
  And it should return rule "3" condition "1" with duration "1" percentage "100" suspension "60" is suppress all "false" facility "Facility Y" unit "" bed ""

  And it should return rule "4" with event label "Tachy" and alert text "Tachy"
  And it should return rule "4" condition "1" with duration "1" percentage "100" suspension "60" is suppress all "false" facility "Facility Y" unit "" bed ""
  
  And it should return rule "5" with event label "VFib/VTac" and alert text "VFib/VTac"
  And it should return rule "5" condition "1" with duration "1" percentage "100" suspension "60" is suppress all "false" facility "Facility Y" unit "" bed ""
  
  And it should return rule "6" with event label "Leads Fail" and alert text "Leads Fail"
  And it should return rule "6" condition "1" with duration "1" percentage "100" suspension "60" is suppress all "true" facility "Facility Z" unit "" bed ""

