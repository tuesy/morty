Feature: Generating estimates via the API

Background:
  Given I send and accept JSON

Scenario: Give me my estimate
  When I send a POST request to "/api/estimates" with the following:
    """
    {"annualincome":"50000","downpayment":"10000"}
    """
  Then the response status should be "201"
  And the JSON response should have "$..price" with the text "340000"

Scenario: Accepts commas
  When I send a POST request to "/api/estimates" with the following:
    """
    {"annualincome":"50,000","downpayment":"10,000"}
    """
  Then the JSON response should have "$..price" with the text "340000"

Scenario: Errors
  When I send a POST request to "/api/estimates" with the following:
    """
    {"annualincome":"50,000","downpayment":""}
    """
  Then the response status should be "422"
