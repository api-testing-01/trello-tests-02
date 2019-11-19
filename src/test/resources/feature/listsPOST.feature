Feature: Lists POST
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

  @cleanData
  Scenario: POST list with wrong endpoint
    When I send a "POST" request to "/listsAbc" with json body
    """
    {
    "name": "List created by POST cucumber",
    "idBoard": "(B.id)"
     }
    """
    And I save the response as "R"
    Then I validate the response has status code 404
    And I validate the response contains "Cannot POST /1/listsAbc"


  @cleanData
  Scenario Outline: POST list with invalid required fields
    When I send a "POST" request to "/lists" with json body
    """
    {
    <field1> <value1>
    <field2> <value2>
     }
    """
    And I save the response as "R"
    Then I validate the response has status code 400
    And I validate the response contains "<errorMessage>"
  Examples:
    | field1  | value1                           | field2     | value2   | errorMessage              |
    | "name": | "List created by POST cucumber"  |            |          | invalid value for idBoard |
    |         |                                  | "idBoard": | "(B.id)" | invalid value for name    |
    |         |                                  |            |          | invalid value for name    |
    | "name": | "List created by POST cucumber", | "idBoard": | "123"    | invalid value for idBoard |
    | "name": | "List created by POST cucumber"  | "idBoard": | "(B.id)" | Error parsing body        |