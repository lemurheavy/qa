Feature: Create question
  In order to be able to effectively use the site
  As a user
  I want to be able to create questions and view them

  Scenario: Cannot create question when not logged in
    Given I am on the homepage
    When I click on the Ask Question button
    Then I should be redirected to the homepage

  Scenario: Can create question when logged in
    Given I am on the homepage
    And I am logged in
    When I click on the Ask Question button
    Then I should be on the new question page