Feature: Create answer
  In order to use the site effectively
  As a user
  I want to be able to create answers

  Scenario: Create question as logged in user
    Given I am logged in
    And I have a question
    And I am on the question page
    When I fill in the answer form
    And I click on the submit button
    Then I should be on the question page
    And I should see the answer