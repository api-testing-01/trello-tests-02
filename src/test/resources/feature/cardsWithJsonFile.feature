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
    And I send a "POST" request to "/cards" with json file "json/requestBodyCard.json"
    And I validate the response has status code 200
    And I save the response as "C"

  Scenario: GET Card
    When I send a GET request to "/cards/{C.id}"
    Then I validate the response has status code 200
    And I validate the response contains "name" equals "Api Testing Trello"
    And I send a DELETE request to "/cards/{C.id}"
    And I validate the response has status code 200
