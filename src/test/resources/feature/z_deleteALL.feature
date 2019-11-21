Feature: Delete all boards

  Scenario: Delete all boards of the current member
    Given I use the "trello" service and the "owner" account
    And I get the "idBoards" from current member
    When I delete all result in "/boards"
    Then I validate the response has status code 200

  Scenario: Delete all organizations of the current member
     Given I use the "trello" service and the "owner" account
     And I get the "idOrganizations" from current member
     When I delete all result in "/organizations"
     Then I validate the response has status code 200






