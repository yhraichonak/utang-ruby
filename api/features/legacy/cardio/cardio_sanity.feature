@sanity
Feature: CARDIO API Sanity

  Scenario: Cardio Sanity Check
    Given it should login to the api
    When I execute a version API call
    Then it should return the api version
    When I execute a status API call
    Then it should return the "CARDIO" api status
    When I execute a "CARDIO" patient list API call
    Then it should return the "CARDIO" patient list
    When I execute a search configuration API call
    Then it should return the search configuration
    When I execute a list of lists API call
    Then it should return the list of lists

    When I execute a one param search API call to search for "VAUSS" under "last name" for the "CARDIO" module
    Then it should return "CARDIO" search results for last name of "VAUSS"
      | firstName | lastName | mrn      | age      | moduleId | gender | location       | hospital        | diagnosis               |
      | GREGG     | VAUSS    | EXPPAT01 | 99 YEARS | 1        | MALE   | EMERGENCY ROOM | Automation Site | Left atrial tachycardia |

    When I execute a one param search API call to search for "04/09/1919" under "DOB" for the "CARDIO" module
    Then it should return "CARDIO" search results for DOB "04/09/1919"
      | firstName | lastName | mrn      | age      | moduleId | gender | location       | hospital        | diagnosis               |
      | GREGG     | VAUSS    | EXPPAT01 | 99 YEARS | 1        | MALE   | EMERGENCY ROOM | Automation Site | Left atrial tachycardia |

    When I execute a one param search API call to search for "99" under "age" for the "CARDIO" module
    Then it should return "CARDIO" search results for Age "99"
      | firstName | lastName | mrn      | age      | moduleId | gender | location       | hospital        | diagnosis               |
      | GREGG     | VAUSS    | EXPPAT01 | 99 YEARS | 1        | MALE   | EMERGENCY ROOM | Automation Site | Left atrial tachycardia |

    When I execute a one param search API call to search for "EXPPAT01" under "mrn" for the "CARDIO" module
    Then it should return "CARDIO" search results for mrn "EXPPAT01"
      | firstName | lastName | mrn      | age      | moduleId | gender | location       | hospital        | diagnosis               |
      | Gregg     | Vauss    | EXPPAT01 | 99 YEARS | 1        | MALE   | EMERGENCY ROOM | Automation Site | Left atrial tachycardia |

    Then it should return "CARDIO" ecg list for patient "GREGG" "VAUSS"
      | ecgId | diagnosis               |
      | 145   | Left atrial tachycardia |

    Then it should return "CARDIO" ecg information for ecg id "154"
      | ecgId | diagnosis         |
      | 154   | Test Abnormal ECG |

    Then it should return "CARDIO" ecg request edit for ecg id "162"
      | allowEdit | userMessage                                                             |
      | false      | matches:(Test Is Not Assigned To Your InBasket\|Please Confirm Test By Other Means)|

    Then it should return "CARDIO" ecg list for patient "Nesbitt" "Esron"
      | ecgId | diagnosis           |
      | 162   | Normal sinus rhythm |

    Then it should return "CARDIO" serial presentation for ecgs "162" "154"
      | ecgId | diagnosis           |
      | 162   | Normal sinus rhythm |
      | 154   | Test Abnormal ECG   |

    Then it should return "CARDIO" statement library
      | code      | statement                              |
      | SNF       | STATEMENT NOT FOUND                    |
      | PEDANL    | ** * Pediatric ECG analysis * **       |
      | DICTATION | Report dictated, transcription pending |
  