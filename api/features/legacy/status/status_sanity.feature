@sanity
Feature: STATUS API Sanity

Scenario: Status Sanity Check
 Then it should login to the api
 Then it should return the fed-web status for site "automation"
 