Feature: Test Login
  In order to use application
  As a user
  I want login 
  
  Scenario: user login
    Given I am the test_user
    And I am on the login page
    When I login
    Then I should be redirected to "user account page"
  
  Scenario: admin login
    Given I am the admin_user
    And I am on the login page
    When I login
    Then I should see "Registered Users"
  