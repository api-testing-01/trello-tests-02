Feature: Lists GET and PUT
  Background: Create a List
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
    When I send a "POST" request to "/lists" with json body
    """
    {
    "name": "List created by POST cucumber",
    "idBoard": "(B.id)",
    "pos": 10.5
     }
    """
    Then I validate the response has status code 200
    And I save the response as "L"

  @cleanData
  Scenario: GET list/{id}
    When I send a "GET" request to "/lists/{L.id}"
    Then I validate the response has status code 200
    And I validate the response contains "name" equals "List created by POST cucumber"
    And I validate the response contains "idBoard" equals "{B.id}"
    And I validate the response contains "pos" equals "10.5"
    And I validate the response contains "closed" equals "false"

  @cleanData
  Scenario Outline: GET list/{id}/{field}
    Given I send a "PUT" request to "/lists/{L.id}/<field>" with json body
    """
    {
    "value": <value>
     }
    """
    And I validate the response has status code 200
    When I send a "GET" request to "/lists/{L.id}/<field>"
    Then I validate the response has status code 200
    And I validate the response contains "_value" equals "<result>"
    Examples:
      | field      | value           | result        |
      | closed     | true            | true          |
      | closed     | false           | false         |
      | name       | "Edited by PUT" | Edited by PUT |
      | pos        | 0.25            | 0.25          |
      | subscribed | true            | true          |
      | subscribed | false           | false         |
      | softLimit  | 100             | 100           |
      | idBoard    | "(B.id)"        | {B.id}        |
  @cleanData
  Scenario: GET list/{id}/board
    Given I send a "PUT" request to "/boards/{B.id}" with json body
    """
    {
    "name": "A new Project",
    "desc":"This is the board for list"
     }
    """
    And I validate the response has status code 200
    And I save the response as "B"
    When I send a "GET" request to "/lists/{L.id}/board"
    Then I validate the response has status code 200
    And I validate the response contains "name" equals "A new Project"
    And I validate the response contains "desc" equals "This is the board for list"

  @cleanData
  Scenario Outline: GET list/{id} with wrong URL
    When I send a "GET" request to "<endpoint>/<listId>"
    And I save the response as "R"
    Then I validate the response has status code <errorCode>
    And I validate the response contains "<errorMessage>"
    Examples:
      | endpoint  | listId | errorCode | errorMessage           |
      | /lists123 | {L.id} | 404       | Cannot GET /1/lists123 |
      | /lists    | 123    | 400       | invalid id             |

  @cleanData
  Scenario: PUT list/{id}
    Given I send a "POST" request to "/boards" with json body
    """
    {
    "name": "Board 2 created for PUT validation",
    "defaultLists": false
     }
    """
    And I validate the response has status code 200
    And I save the response as "B2"
    And I save the request endpoint for deleting
    When I send a "PUT" request to "/lists/{L.id}" with json body
    """
    {
    "name": "List Edited by PUT cucumber",
    "closed": true,
    "pos": 10.5,
    "idBoard":"(B2.id)"
     }
    """
    And I validate the response contains "name" equals "List Edited by PUT cucumber"
    And I validate the response contains "idBoard" equals "{B2.id}"
    And I validate the response contains "pos" equals "10.5"
    And I validate the response contains "closed" equals "true"

  @cleanData
  Scenario Outline: PUT list/{id}/field
    When I send a "PUT" request to "/lists/{L.id}/<field>" with json body
    """
    {
    "value": <value>
     }
    """
    Then I validate the response has status code 200
    When I send a "GET" request to "/lists/{L.id}/<field>"
    Then I validate the response has status code 200
    And I validate the response contains "_value" equals "<result>"
    Examples:
      | field      | value           | result        |
      | closed     | true            | true          |
      | closed     | false           | false         |
      | name       | "Edited by PUT" | Edited by PUT |
      | pos        | 0.25            | 0.25          |
      | subscribed | true            | true          |
      | subscribed | false           | false         |
      | softLimit  | 100             | 100           |


  @cleanData
  Scenario: PUT list/{id}/idBoard
    Given I send a "POST" request to "/boards" with json body
    """
    {
    "name": "Board 2 created for PUT validation",
    "defaultLists": false
     }
    """
    And I validate the response has status code 200
    And I save the response as "B2"
    And I save the request endpoint for deleting
    When I send a "PUT" request to "/lists/{L.id}/idBoard" with json body
    """
    {
    "value": "(B2.id)"
     }
    """
    Then I validate the response has status code 200
    When I send a "GET" request to "/lists/{L.id}/idBoard"
    Then I validate the response has status code 200
    And I validate the response contains "_value" equals "{B2.id}"

  @cleanData
  Scenario Outline: PUT list/{id} with wrong URL
    When I send a "PUT" request to "<endpoint>/<listId><field>" with json body
    """
    {
    "name": "new name"
     }
    """
    And I save the response as "R"
    Then I validate the response has status code <errorCode>
    And I validate the response contains "<errorMessage>"
    Examples:
      | endpoint  | listId  | errorCode | errorMessage                                | field            |
      | /lists123 | {L.id}/ | 404       | Cannot PUT /1/lists123/{L.id}               |                  |
      | /lists    | 123/    | 400       | invalid id                                  |                  |
      | /lists    | {L.id}/ | 404       | Cannot PUT /1/lists/{L.id}/nonExistentField | nonExistentField |