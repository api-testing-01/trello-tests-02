Feature: Boards

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
    """
    {
    "name": "Board0001 created by cucumber"
    }
    """
    And I save the response as "P"

  @cleanData
  Scenario: PUT Board, edit name
    When I send a "PUT" request to "/boards/{P.id}" with json body
    """
    {
    "name": "Board0001 updated by cucumber"
    }
    """
    Then I validate the response has status code 200
    And I validate the response contains "name" equals "Board0001 updated by cucumber"
    And I send a "DELETE" request to "/boards/{P.id}"
    And I validate the response has status code 200

  @cleanData
  Scenario: PUT Board, edit permission level
    When I send a "PUT" request to "/boards/{P.id}" with json body
    """
    {
    "prefs_permissionLevel": "private"
    }
    """
    Then I validate the response has status code 200
    And I validate the response contains "prefs.permissionLevel" equals "private"
    And I send a "DELETE" request to "/boards/{P.id}"
    And I validate the response has status code 200

  @cleanData
  Scenario: try edit a board no exist
    When I send a "PUT" request to "/boards/1326546987" with json body
    """
    {
    "name": "Board0001 updated by cucumber"
    }
    """
    Then I validate the response has status code 400
