@ahi @sanity
Feature: AHI API Sanity

I am testing the AHI

TestRail Id: 
  
Background:

Scenario: AHI Sanity Check
 Given I login to the api with a valid credential
 Then I should receive an xAuthToken
 When I execute AHI status API call
 Then I should receive a fifthEye success response with version number
 #When I execute AHI PostPatientList API call
   