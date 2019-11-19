Feature: CardsLabels

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
    """
    {
    "name": "Board [Labels TC]"
    }
    """
    And I save the response as "B"
    And I save the request endpoint for deleting
    And I send a "POST" request to "/lists" with json body
    """
    {
    "name": "List [Labels TC]",
    "idBoard": "(B.id)"
    }
    """
    And I save the response as "L"
    And I send a "POST" request to "/cards" with json body
    """
    {
    "name": "Card [Labels TC]",
    "idList": "(L.id)"
    }
    """
    And I save the response as "C"

  @cleanData
  Scenario: POST Card Label
    When I send a "POST" request to "/cards/{C.id}/labels" with json body
    """
    {
    "id": "(C.id)",
    "name": "In progress",
    "color": "purple"
    }
    """
    Then I save the response as "Lbl"
    And I validate the response has status code 200
    And I validate the response contains "name" equals "In progress"

  @CleanData @WIP
  Scenario: Delete Card Label
    When I send a "DELETE" request to "/cards/{C.id}/idLabels/{Lbl.idLabel}"
    Then I validate the response has status code 200
