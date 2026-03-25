@sanity
Feature: FED API Sanity

Scenario: General Sanity Check
 Then it should login to the api
 Then it should not login to the api with "username" and "NOTCORRECT123"
