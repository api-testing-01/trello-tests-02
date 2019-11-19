Feature: Board create feature

  @cleanData
  Scenario: Crate a private board
    Given I use the "trello" service and the "owner" account
    When I send a "POST" request to "/boards" with json body
    """
    {
    "name": "BoardCreate001 created by cucumber",
    "prefs_permissionLevel": "private"
    }
    """
    And I save the response as "P"
    Then I send a "GET" request to "/boards/{P.id}"
    And I validate the response contains "prefs.permissionLevel" equals "private"
    And I validate the response contains "name" equals "BoardCreate001 created by cucumber"

  @cleanData
  Scenario: Crate a public board
    Given I use the "trello" service and the "owner" account
    When I send a "POST" request to "/boards" with json body
    """
    {
    "name": "BoardCreate002 created by cucumber",
    "prefs_permissionLevel": "public"
    }
    """
    And I save the response as "P"
    Then I send a "GET" request to "/boards/{P.id}"
    And I validate the response contains "prefs.permissionLevel" equals "public"
    And I validate the response contains "name" equals "BoardCreate001 created by cucumber"