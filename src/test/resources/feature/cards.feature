Feature: Cards

  Background:
    Given I use the "trello" service and the "owner" account
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
    "idBoard": "4d5ea62fd76aa1136000000c"
    }
    """
    And I validate the response has status code 200
    And I save the response as "C"

  Scenario: GET Cards
    When I send a GET request to "/cards/{C.id}"
    Then I validate the response has status code 200
    And I validate the response contains "name" equals "Api Testing Trello"
    And I send a DELETE request to "/cards/{C.id}"
    And I validate the response has status code 200
