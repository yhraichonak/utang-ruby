@sanity
Feature: AMP API Sanity

  Scenario: AMP Sanity Check

  Then it should login to the api
  Then it should return a valid shared security key for site "4751" and key name "share_key"
  Then it should not return a valid shared security key for site "4751" and key name "$%^^("
  Then it should return all enterprise users
  Then it should return true for a valid user "scottgillenwater" for site "4751" and reg code "00000000000"
  Then it should return true for a valid user "hknowlson" for site "4751" and reg code ""
  Then it should return true for a valid user "tworthing" for site "4751" and reg code "13224-781669"
  Then it should return true for a valid user "jeanettetorres" for site "4751" and reg code "13200-208279"
  Then it should return true for a valid user "mickeymouse" for site "4751" and reg code "121323211234-208279"

      Then it should return module instance configuration with id "100"
        | hasEditsAndConfirms | hasEditsAndConfirmsInbox | siteVirtualizationEnabled | mmivEnabled | moduleInstanceId | moduleInstanceName       | moduleInstanceBaseUrl    | siteId | siteName        | dualAuthenticationEnabled |
        | true                | true                     | false                     | false       | 100              | Automation Site - MuseNX | http://10.106.5.18:9000/ | 4751   | Automation Site | false                     |

  Then it should return module instance configuration with id "101" snippet
        | snippetsEnabled | dualLead | moduleInstanceId | moduleInstanceName | moduleInstanceBaseUrl                | siteId | siteName  | dualAuthenticationEnabled |
        | true           | false     | 101              | Automation Site             |http://10.106.5.18:8765| 4751   | Automation Site    | false                     |

  Then it should return module instance configuration with id "103"
    | moduleInstanceId | moduleInstanceName | moduleInstanceBaseUrl           | siteId | siteName        | dualAuthenticationEnabled |
                                                                      | 103			  | MSG			   | http://10.106.5.18/fed-host/api/messaging | 4751   | Automation Site              | false					  |
  Then it should return module instance configuration with id "108"
  | hasEditsAndConfirms | hasEditsAndConfirmsInbox | siteVirtualizationEnabled | mmivEnabled | moduleInstanceId | moduleInstanceName       | moduleInstanceBaseUrl    | siteId | siteName        | dualAuthenticationEnabled |
  | false                | false                     | false                     | false       | 108              | Auto2Cardio | http://10.106.5.18:9000/ | 4802   | Automation Site Con| false                     |


  Then it should return module instance configuration with id "1111111111"
      | hasEditsAndConfirms | hasEditsAndConfirmsInbox | siteVirtualizationEnabled | mmivEnabled | moduleInstanceId | moduleInstanceName | moduleInstanceBaseUrl   | siteId    | siteName  | dualAuthenticationEnabled |
      | INVALIDID				  | INVALIDID			 | INVALIDID				 | INVALIDID   | INVALIDID	      | INVALIDID    	   | INVALIDID               | INVALIDID | INVALIDID | INVALIDID				 |

  Then it should return module instance user configuration with module id "100" and user "utang"
      | activeDirectoryUsername | userFullName    | moduleInstanceId | moduleInstanceName | hasEditsAndConfirmsCapability | canConfirmOutOfInbasket | isAvailableForNotifications |
      | utang				  | utang User	| 100			   | Automation Site - MuseNX            | true    		 	    	    | false			    	  | true               			|


  Then it should return module instance user configuration with module id "9999" and user "invalid"
      | activeDirectoryUsername | userFullName | moduleInstanceId | moduleInstanceName | hasEditsAndConfirmsCapability | canConfirmOutOfInbasket | isAvailableForNotifications |
      | INVALIDID				  | INVALIDID	 | INVALIDID	   	| INVALIDID          | INVALIDID     		 	     | INVALIDID			   | INVALIDID           		 |


  Then it should return enterprise user vendor credentials with user "cardiacfellow" vendor system "MUSE" and module instance "100"
      | userFullName    | vendorSystemId | vendorSystemName | moduleInstanceId | moduleInstanceName |
      | cardiacfellow 		  | 1              | MUSE			  | 100     	     | Automation Site - MuseNX			      |


  Then it should return enterprise user vendor credentials with user "username" vendor system "MUSE" and module instance "110034"
      | activeDirectoryUsername | userFullName | moduleInstanceId | moduleInstanceName | hasEditsAndConfirmsCapability | canConfirmOutOfInbasket | isAvailableForNotifications |
      | INVALIDID				  | INVALIDID	 | INVALIDID	   	| INVALIDID          | INVALIDID     		 	     | INVALIDID			   | INVALIDID           		 |


      Then it should return enterprise user vendor credentials with user "utang" vendor system "Muse" and module instance "100"
      | userFullName    | vendorSystemId | vendorSystemName | moduleInstanceId | moduleInstanceName |
      | utang 		  | 2              | Muse			  | 100     	     | Automation Site - MuseNX		      |
