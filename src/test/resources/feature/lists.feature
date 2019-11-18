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
    "idBoard": "(B.id)"
     }
    """
    Then I validate the response has status code 200
    And I validate the response contains "name" equals "List created by POST cucumber"
    #And I validate the response contains "idBoard" equals "{B.id}"
    #And I validate the response contains "pos" equals "top"
    #And I validate the response contains "closed" equals "false"

  @cleanData
  Scenario: PUT list
    Given I send a "POST" request to "/lists" with json body
    """
    {
    "name": "List created by POST cucumber",
    "idBoard": "(B.id)"
     }
    """
    And I validate the response has status code 200
    And I save the response as "L"
    When I send a "PUT" request to "/lists/{L.id}" with json body
    """
    {
    "name": "List Edited by PUT cucumber"
     }
    """
    And I validate the response contains "name" equals "List Edited by PUT cucumber"
    #And I validate the response contains "idBoard" equals "{B.id}"
    #And I validate the response contains "pos" equals "top"
    #And I validate the response contains "closed" equals "false"

  @cleanData
  Scenario: GET List
    Given I send a "POST" request to "/lists" with json body
    """
    {
    "name": "List created by POST cucumber",
    "idBoard": "(B.id)"
     }
    """
    And I validate the response has status code 200
    And I save the response as "L"
    When I send a "GET" request to "/lists/{L.id}"
    And I validate the response contains "name" equals "List created by POST cucumber"
    #And I validate the response contains "idBoard" equals "{B.id}"
    #And I validate the response contains "pos" equals "top"
    #And I validate the response contains "closed" equals "false"