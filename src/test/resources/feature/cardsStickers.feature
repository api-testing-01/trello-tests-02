Feature: CardsStickers

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
    """
    {
    "name": "Board [Stickers TC]"
    }
    """
    And I save the response as "B"
    And I save the request endpoint for deleting
    And I send a "POST" request to "/lists" with json body
    """
    {
    "name": "List [Stickers TC]",
    "idBoard": "(B.id)"
    }
    """
    And I save the response as "L"
    And I send a "POST" request to "/cards" with json body
    """
    {
    "name": "Card [Stickers TC]",
    "idList": "(L.id)"
    }
    """
    And I save the response as "C"

  @cleanData @WIP
  Scenario: POST Card Sticker
    When I send a "POST" request to "/cards/{C.id}/stickers" with json body
    """
    {
    "id": "(C.id)",
    "top": 0,
    "left": 47.31,
    "zIndex": 1,
    "rotate": -7,
    "image": "taco-alert",
    "imageUrl": "https://d2k1ftgv7pobq7.cloudfront.net/images/stickers/taco-alert.png",
    }
    """
    Then I validate the response has status code 200
    And I validate the response contains "image" equals "taco-alert"
