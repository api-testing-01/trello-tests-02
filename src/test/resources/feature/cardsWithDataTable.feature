Feature: Cards

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
    """
    {
    "name": "Lizzy's Board"
    }
    """
    And I save the response as "B"
    And I save the request endpoint for deleting
    And I send a "POST" request to "/lists" with json body
    """
    {
    "name": "Lizzy's List",
    "idBoard": "(B.id)"
    }
    """
    And I save the response as "L"
    And I send a "POST" request to "/cards" with with datatable
      | name   | Api Testing Trello          |
      | desc   | For testing                 |
      | pos    | top                         |
      | idList | (L.id)                      |
    And I save the response as "P"
    And I save the request endpoint for deleting

  @cleanData
  Scenario Outline: PUT Card
    When I send a "PUT" request to "/cards/{C.id}" with datatable
      | name   | Api Testing Trello [PUT]  |
      | pos    | bottom                    |
    Then I validate the response has status code 200
    And I validate the response contains "name" equals "Api Testing Trello [PUT]"
    And I validate the response contains "pos" equals "bottom"