@sanity
Feature: GLOBAL SERVICES API Sanity
 
Scenario: Global Services Sanity Check
  Then it should signon ios device with username tag
  Then it should signon new ios device with username tag
  Then it should signon new android device with username tag
  Then it should signon windows device with username tag
  Then it should signon other ios device with tester9657648
  Then it should return the site list for test@test.com new iOS device
  Then it should not return the site list with empty reg code
  Then it should not return the site list with empty device_id
  Then it should not return the site list with ivalid device_id
  Then it should not return the site list with empty device_id and reg code
  Then it should return the site list for test@test.com new android device
  Then it should return the site list for tester9657648@test other iOS device
  Then it should check device for ios device
  Then it should check device for android device
  Then it should not check device for android device invalid reg code
  Then it should not check device for android device invalid device
  Then it should get device from registration code
  Then it return the client configuration
  Then it should register test user for push notification android device qa
  Then it should register test user for push notification android device prod
  Then it should create a new user
  Then it should not create an existing user
  Then it should signon with new android user created
  Then it should check device for new android user created
  Then it should return the site list for new android user created
  Then it should return the client configuration for new android user created
  Then it should return the eula
  
  Then it should not signon other ios device with invalid password
  Then it should not signon with invalid username
  Then it should update the site information
  Then it should update the site information back to normal
  Then it should return the next http client configuration id
  Then it should return the next site id
  Then it should update the client configuration
  Then it should update the client configuration to original
  Then it should add reg code to site
  Then it should return the site list for newly added reg code to site
  
  
  
  