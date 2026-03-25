@sanity
Feature: MPID API Sanity
 
Scenario: MPID Sanity Check
  Then it should login to the api
  
  Then it should sync Patient MPID "{"KEY1":{"module":2,"mrn":"123456","firstName":"Scott","lastName":"Gill","mrncontext":"1","associable":false}}"
  
  Then it should sync Patient MPID "{"KEY1":{"module":2,"mrn":"123456","firstName":"Scott","lastName":"Gill","mrncontext":"1","associable":true}}"
  Then it should sync Patient MPID "{"KEY1":{"module":1,"mrn":"789456","firstName":"Test","lastName":"Tester","mrncontext":"1","associable":true}}"
  Then it should sync Patient MPID "{"KEY1":{"module":1,"mrn":"789456","firstName":"Test","lastName":"Tester","mrncontext":"2","associable":true}}"
  Then it should sync Patient MPID "{"KEY1":{"module":2,"mrn":"123456","firstName":"Scott","lastName":"Gill","mrncontext":"1","associable":true}}"
  Then it should sync Patient MPID "{"KEY1":{"module":2,"mrn":"000111222333444","firstName":"Brandon","lastName":"Marshall","mrncontext":"1","associable":true}}"
  Then it should sync Patient MPID "{"KEY1":{"module":2,"mrn":"111222333444","firstName":"Brandon","lastName":"Marshall","mrncontext":"1","associable":true}}"
  Then it should sync Patient MPID "{"KEY1":{"module":1,"mrn":"NWH555666777888","firstName":"Jay","lastName":"Cutler","mrncontext":"1","associable": true}}"
  Then it should sync Patient MPID "{"KEY1":{"module":3,"mrn":"JFK555666777888","firstName":"Jay","lastName":"Cutler","mrncontext":"1","associable":true}}"
  Then it should sync Patient MPID "{"KEY1":{"module":1,"mrn":"555666777888","firstName":"Jay","lastName":"Cutler","mrncontext":"1","associable":true}}"
  Then it should sync Patient MPID "{"KEY1":{"module":4,"mrn":"JFK999333445","firstName":"Nolan","lastName":"Ryan","mrncontext":"1","associable":true}}"
  Then it should sync Patient MPID "{"KEY1":{"module":4,"mrn":"999333445","firstName":"Nolan","lastName":"Ryan","mrncontext":"1","associable":true}}"
  Then it should sync Patient MPID "{"KEY1":{"module":4,"mrn":"FK999333445","firstName":"Nolan","lastName":"Ryan","mrncontext":"1","associable":true}}"
  Then it should sync Patient MPID "{"KEY1":{"module":3,"mrn":"JFK999333445","firstName":"Nolan","lastName":"Ryan","mrncontext":"1","associable":true}}"
  Then it should sync Patient MPID "{"KEY1":{"module":1,"mrn":"789456","firstName":"Test","lastName":"Tester","mrncontext":"1","birthdate":"1980-12-12","associable":true}}"