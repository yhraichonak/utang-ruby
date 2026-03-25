@skip @sanity
Feature: ACWA QA API Sanity

I am testing the ACM QA API

TestRail Id: 
  
Background:
  

Scenario: ACWA Status Sanity
Then it should return the ACWA status
  | machineName         | 
  | ASTQAFEDHOST03      |

Scenario: ACWA Version Sanity
Then it should return the ACWA version
  | applicationVersion  | domainVersion | name          | version   | date          | info                                                          |
  | 5.8.9911.0          | 5.8.9911.0    | EcgMagic      | 0.1.7.0   | Sep 27 2021   | Algorithm=0.1.1 22 Dec 2019, EcgMagicDllVersion=4.3.9900.0    |
  
Scenario: ACM Rules Sanity
Then it should return the ACWA rules

Scenario: Frat Configuration Sanity
Then it should return the FRAT even descriptions
 | majorCategory  | minorCategory               | freeText  |
 |     ATach      | Atrial Tachycardia          |           |
 |     HB 1       | Heart Block  First Degree   |           |

Scenario: FRAT users Sanity
Then it should return the FRAT users

Scenario: Frat Records full Sanity
Then it should return the FRAT records full

Scenario: FRAT Records headers Sanity
Then it should return the FRAT records headers

Scenario: FRAT Records Sanity
Then it should return the FRAT records

Scenario:  FRAT Records ids Sanity
Then it should return the FRAT records ids

Scenario: FRAT Records by id Sanity
Then it should return the FRAT records by id "ad985f36-b059-45a2-90a0-527d3440ab00"

Scenario: FRAT Records Summary by id Sanity
Then it should return the FRAT records summary by id "ad985f36-b059-45a2-90a0-527d3440ab00"


