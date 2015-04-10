Feature: Homepage

Scenario: Get my estimate
  Given I am on the homepage
  When I fill in "annualincome" with "50000"
  And I fill in "downpayment" with "10000"
  And I press "Estimate"
  Then I should see "$340,000"

Scenario: Accepts commas
  Given I am on the homepage
  When I fill in "annualincome" with "50,000"
  And I fill in "downpayment" with "10,000"
  And I press "Estimate"
  Then I should see "$340,000"
