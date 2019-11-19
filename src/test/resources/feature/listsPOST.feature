Feature: Lists
  Background: Create a Board
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
    """
    {
    "name": "Board created by POST cucumber",
    "defaultLists": false
     }
    """
    And I validate the response has status code 200
    And I save the response as "B"
    And I save the request endpoint for deleting

  @cleanData
  Scenario: POST list
    When I send a "POST" request to "/lists" with json body
    """
    {
    "name": "List created by POST cucumber",
    "idBoard": "(B.id)",
    "pos": 10.5
     }
    """
    Then I validate the response has status code 200
    And I validate the response contains "name" equals "List created by POST cucumber"
    And I validate the response contains "idBoard" equals "{B.id}"
    And I validate the response contains "pos" equals "10.5"
    And I validate the response contains "closed" equals "false"