Feature: Boards

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
    """
    {
    "name": "Board0001 to delete"
    }
    """
    And I save the response as "P"

  @cleanData
  Scenario: Delete Board
    When I send a "DELETE" request to "/boards/{P.id}"
    Then I validate the response has status code 200
    And I send a "GET" request to "/boards/{P.id}"
    And I validate the response has status code 404


  @cleanData
  Scenario: try delete a board no exist
    When I send a "DELETE" request to "/boards/132456987"
    Then I validate the response has status code 400
