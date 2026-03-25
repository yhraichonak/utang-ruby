@sanity @skip
Feature: PM API Sanity

  Scenario:  PM Sanity Check
    Given I login to the api with a valid credential
    Then I should receive an xAuthToken
    When I execute a version API call
    Then it should return the api version
    When I execute a status API call
    Then it should return the "PM" api status
    When I execute a "PM" patient list API call
    Then it should return the "PM" patient list
    When I execute a search configuration API call
    Then it should return the search configuration
    When I execute a list of lists API call
    Then it should return the list of lists

    When I execute a one param search API call to search for "[props.DP_LNAME]" under "last name" for the "PM" module
    Then it should return "PM" search results for last name of "[props.DP_LNAME]"
      | firstName        | lastName         | mrn                 | status            | moduleId          | location            | unit            |
      | [props.DP_FNAME] | [props.DP_LNAME] | [props.DP_MRN] | [props.DP_STATUS] | [props.DP_MODULE] | [props.DP_LOCATION] | [props.DP_UNIT] |
    
 When I execute a one param search API call to search for "[props.DP_FNAME]" under "first name" for the "PM" module
 Then it should return "PM" search results for first name of "[props.DP_FNAME]"
  | firstName | lastName | mrn      | status | moduleId | location | unit |
  | [props.DP_FNAME]      | [props.DP_LNAME]   | [props.DP_MRN]   | [props.DP_STATUS]  | [props.DP_MODULE]         | [props.DP_LOCATION]      | [props.DP_UNIT]  |

 When I execute a one param search API call to search for "[props.DP_UNIT]" under "unit" for the "PM" module
 Then it should return "PM" search results for unit "[props.DP_UNIT]"

 When I execute a one param search API call to search for "[props.DP_LOCATION]" under "bed" for the "PM" module
 Then it should return "PM" search results for bed "[props.DP_LOCATION]"

 When I execute a one param search API call to search for "[props.DP_MRN]" under "mrn" for the "PM" module
 Then it should return "PM" search results for mrn "[props.DP_MRN]"
  | firstName | lastName | mrn      | status | moduleId | location | unit |
  | [props.DP_FNAME]      | [props.DP_LNAME]   | [props.DP_MRN]   | [props.DP_STATUS]  | [props.DP_MODULE]         | [props.DP_LOCATION]      | [props.DP_UNIT]  |

 When I execute a two param search API call to search for "[props.DP_FNAME]" under "firstname" and "[props.DP_LNAME]" under "lastname" for the "PM" module
 Then it should return "PM" results for two parameter search "firstname" of "[props.DP_FNAME]" and "lastname" of "[props.DP_LNAME]"
  | firstName | lastName | mrn      | status | moduleId | location | unit |
  | [props.DP_FNAME]      | [props.DP_LNAME]   | [props.DP_MRN]   | [props.DP_STATUS]  | [props.DP_MODULE]         | [props.DP_LOCATION]      | [props.DP_UNIT]  |

 When I execute a two param search API call to search for "[props.DP_FNAME]" under "firstname" and "[props.DP_LOCATION]" under "location" for the "PM" module
 Then it should return "PM" results for two parameter search "lastname" of "[props.DP_LNAME]" and "location" of "[props.DP_LOCATION]"
  | firstName | lastName | mrn      | status | moduleId | location | unit |
  | [props.DP_FNAME]      | [props.DP_LNAME]   | [props.DP_MRN]   | [props.DP_STATUS]  | [props.DP_MODULE]         | [props.DP_LOCATION]      | [props.DP_UNIT]  |

 When I execute a two param search API call to search for "[props.DP_UNIT]" under "unit" and "[props.DP_LNAME]" under "lastname" for the "PM" module
 Then it should return "PM" results for two parameter search "unit" of "[props.DP_UNIT]" and "lastname" of "[props.DP_LNAME]"
  | firstName | lastName | mrn      | status | moduleId | location | unit |
  | [props.DP_FNAME]      | [props.DP_LNAME]   | [props.DP_MRN]   | [props.DP_STATUS]  | [props.DP_MODULE]         | [props.DP_LOCATION]      | [props.DP_UNIT]  |

 When I execute a three param search API call to search for "[props.DP_UNIT]" under "unit" and "[props.DP_LNAME]" under "lastname" and "[props.DP_LOCATION]" under "location" for the "PM" module
 Then it should return "PM" results for three parameter search "unit" of "[props.DP_UNIT]" and "lastname" of "[props.DP_LNAME]" and "location" of "[props.DP_LOCATION]"
  | firstName | lastName | mrn      | status | moduleId | location | unit |
  | [props.DP_FNAME]      | [props.DP_LNAME]   | [props.DP_MRN]   | [props.DP_STATUS]  | [props.DP_MODULE]         | [props.DP_LOCATION]      | [props.DP_UNIT]  |

 When I execute a two param search API call to search for "[props.DP_FNAME]" under "firstname" and "[props.DP_LNAME]" under "lastname" for the "PM" module
 Then it should return "PM" patient summary for "[props.DP_FNAME]" "[props.DP_LNAME]"
  | mrn      |
  | [props.DP_MRN]   |

  #Then it should return "PM" events for "MARIA" "HALE"
  #| mrn          |
  #| 4567812395   |

 When I execute a two param search API call to search for "[props.DP_FNAME]" under "firstname" and "[props.DP_LNAME]" under "lastname" for the "PM" module
 Then it should return "PM" events for "[props.DP_FNAME]" "[props.DP_LNAME]"
  | mrn    |
  | [props.DP_MRN] |

#  When I execute a two param search API call to search for "[props.DP_FNAME]" under "firstname" and "[props.DP_LNAME]" under "lastname" for the "PM" module
#  Then it should return "PM" monitor config for "[props.DP_FNAME]" "[props.DP_LNAME]"
#   | mrn    |
#   | [props.DP_MRN] |

 When I execute a two param search API call to search for "[props.DP_FNAME]" under "firstname" and "[props.DP_LNAME]" under "lastname" for the "PM" module
 Then it should return "PM" measurements for "[props.DP_FNAME]" "[props.DP_LNAME]"
  | mrn    |
  | [props.DP_MRN] |

 When I execute a two param search API call to search for "[props.DP_FNAME]" under "firstname" and "[props.DP_LNAME]" under "lastname" for the "PM" module
 Then it should return "PM" trends for "[props.DP_FNAME]" "[props.DP_LNAME]"
  | mrn    |
  | [props.DP_MRN] |

  
  
  