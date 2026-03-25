@version
Feature: Version Endpoint

  Scenario: User is able to get Version data
    Given I login to the api with a valid credential
    When user executes version GET request
    When system should return version
    """
    {"version":"[props.COMMON_BUILD]","apiVersion":"[props.COMMON_API_BUILD]"}
    """