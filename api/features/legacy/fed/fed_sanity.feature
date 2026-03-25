@sanity
Feature: FED API Sanity

Scenario: FED Sanity Check
Then it should login to the api
Then it should return user configuration for "ratyrejo"
Then it should return user configuration for "anelson"
Then it should return user configuration for "utang"