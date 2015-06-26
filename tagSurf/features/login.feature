Feature: Log into account
  
Scenario: Log into app
  Given I am on the Welcome Screen
  And I enter the credentials "surfdemo@tagsurf.co" "swiperight"
  When I press the login button
  Then I should see the main page in 5 seconds


