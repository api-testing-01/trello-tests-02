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

  @cleanData
  Scenario: PUT list/{id}
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
    "name": "List Edited by PUT cucumber",
    "closed": true,
    "pos": 10.5
     }
    """
    And I validate the response contains "name" equals "List Edited by PUT cucumber"
    And I validate the response contains "idBoard" equals "{B.id}"
    And I validate the response contains "pos" equals "10.5"
    And I validate the response contains "closed" equals "true"

  @cleanData
  Scenario Outline: PUT list/{id}/field
    Given I send a "POST" request to "/lists" with json body
    """
    {
    "name": "List created by POST cucumber",
    "idBoard": "(B.id)"
     }
    """
    And I validate the response has status code 200
    And I save the response as "L"
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
      | field  | value | result |
      | closed | true  | true   |
      | closed | false | false  |
      | name   | "Edited by PUT"  | Edited by PUT   |
      | pos   | 0.25  | 0.25   |
      | subscribed   | true  | true   |
      | subscribed   | false | false   |
#      | idBoard   | "newId"  | "newId"   |
      | softLimit   | 100  | 100   |

  @cleanData
  Scenario: GET list/{id}
    Given I send a "POST" request to "/lists" with json body
    """
    {
    "name": "List created by POST cucumber",
    "idBoard": "(B.id)",
    "pos": 10.5
     }
    """
    And I validate the response has status code 200
    And I save the response as "L"
    When I send a "GET" request to "/lists/{L.id}"
    Then I validate the response has status code 200
    And I validate the response contains "name" equals "List created by POST cucumber"
    And I validate the response contains "idBoard" equals "{B.id}"
    And I validate the response contains "pos" equals "10.5"
    And I validate the response contains "closed" equals "false"

  @cleanData
  Scenario Outline: GET list/{id}/{field}
    Given I send a "POST" request to "/lists" with json body
    """
    {
    "name": "List created by POST cucumber",
    "idBoard": "(B.id)",
    "pos": 10.5
     }
    """
    And I validate the response has status code 200
    And I save the response as "L"
    And I send a "PUT" request to "/lists/{L.id}/<field>" with json body
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
      | field  | value | result |
      | closed | true  | true   |
      | closed | false | false  |
      | name   | "Edited by PUT"  | Edited by PUT   |
      | pos   | 0.25  | 0.25   |
      | subscribed   | true  | true   |
      | subscribed   | false  | false   |
      | softLimit   | 100  | 100   |
      | idBoard   | "(B.id)"  | {B.id}   |