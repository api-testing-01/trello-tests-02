Feature: Delete boards
  
  Background:
    Given I use the "trello" service and the "owner" account
    And I send a GET request to "members/brayanrosas1"
    And I save the response as "B"

Scenario Outline: Delete all boards
    When I send a DELETE request to "/boards/{B.idBoards[<i>]}"
    Then I validate the response has status code 200
  Examples:
    | i |
    | 0 |
    | 1 |
    | 2 |
    | 3 |
    | 4 |
    | 5 |
    | 6 |
    | 7 |
    | 8 |
    | 9 |



