Feature: Lists POST to process cards
  Background: Create a List with two cards
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
    """
    {
    "name": "A Board created for POST with cards",
    "defaultLists": false
     }
    """
    And I validate the response has status code 200
    And I save the response as "B"
    And I save the request endpoint for deleting
    And I send a "POST" request to "/lists" with json body
    """
    {
    "name": "List created by POST Cards",
    "idBoard": "(B.id)"
     }
    """
    And I validate the response has status code 200
    And I save the response as "L"
    When I send a "POST" request to "/cards" with json body
    """
    {
    "name": "Feature 1 - Testing Trello",
    "desc": "This is a card 1 for testing ",
    "idList": "(L.id)"
    }
    """
    And I validate the response has status code 200
    And I save the response as "C1"
    When I send a "POST" request to "/cards" with json body
    """
    {
    "name": "Feature 2 - Testing Trello",
    "desc": "This is a card 2 for testing ",
    "idList": "(L.id)"
    }
    """
    And I validate the response has status code 200
    And I save the response as "C2"

  @cleanData
  Scenario: POST list/{id}/archiveAllCards
    When I send a "POST" request to "/lists/{L.id}/archiveAllCards" with json body
    """
      {
       }
      """
    And I validate the response has status code 200
    Then I send a "GET" request to "/cards/{C1.id}/closed"
    And I validate the response has status code 200
    And I validate the response contains "_value" equals "true"
    And I send a "GET" request to "/cards/{C2.id}/closed"
    And I validate the response has status code 200
    And I validate the response contains "_value" equals "true"

  @cleanData
  Scenario: POST list/{id}/archiveAllCards
    Given I send a "POST" request to "/lists" with json body
    """
    {
    "name": "List 2 where cards will be moved to",
    "idBoard": "(B.id)"
     }
    """
    And I validate the response has status code 200
    And I save the response as "L2"
    When I send a "POST" request to "/lists/{L.id}/moveAllCards" with json body
    """
      {
      "idBoard":"(B.id)",
      "idList":"(L2.id)"
       }
      """
    And I validate the response has status code 200
    Then I send a "GET" request to "/cards/{C1.id}/idList"
    And I validate the response has status code 200
    And I validate the response contains "_value" equals "{L2.id}"
    And I send a "GET" request to "/cards/{C2.id}/idList"
    And I validate the response has status code 200
    And I validate the response contains "_value" equals "{L2.id}"