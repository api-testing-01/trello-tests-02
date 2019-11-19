Feature: Boards

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
    """
    {
    "name": "Board0001 created by cucumber"
    }
    """
    And I save the response as "P"

  @cleanData
  Scenario: Read Board
    When I send a "GET" request to "/boards/{P.id}"
    Then I validate the response has status code 200
    And I validate the response contains "name" equals "Board0001 created by cucumber"

  @cleanData
  Scenario: try read a board no exist
    When I send a "GET" request to "/boards/123654687"
    Then I validate the response has status code 400
