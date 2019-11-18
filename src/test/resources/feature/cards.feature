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
    And I send a "POST" request to "/cards" with json body
    """
    {
    "name": "Api Testing Trello",
    "closed": false,
    "dateLastActivity": "2017-04-07T21:26:00.365Z",
    "desc": "Allows you to stay on top of the progress of any project by sending updates to Slack channels when activity occurs on Trello cards, lists, and boards. Customizable.\n\nRead more: http://blog.trello.com/slack-power-up-trello-alerts",
    "descData": {
      "emoji": {

      }
    },
    "due": null,
    "dueComplete": false,
    "idList": "(L.id)"
    }
    """
    And I save the response as "C"
    And I save the request endpoint for deleting

  Scenario: GET Card
    When I send a GET request to "/cards/{C.id}"
    Then I validate the response has status code 200
    And I validate the response contains "name" equals "Api Testing Trello"
    And I send a DELETE request to "/cards/{C.id}"
    And I validate the response has status code 200

  @cleanData
  Scenario: PUT Card
    When I send a "PUT" request to "/cards/{C.id}" with json body
    """
    {
    "name": "Api Testing Trello [PUT]"
    }
    """
    Then I validate the response has status code 200
    And I validate the response contains "name" equals "Api Testing Trello [PUT]"

  @cleanData
  Scenario: DELETE Card
    When I send a "DELETE" request to "/cards/{C.id}"
    Then I validate the response has status code 200
