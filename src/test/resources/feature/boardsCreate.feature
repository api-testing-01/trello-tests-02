Feature: Board create feature

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
    Then I send a "GET" request to "/cards/{P.id}"
    And I validate the response contains "prefs_permissionLevel" equals "private"
    And I validate the response contains "name" equals "BoardCreate001 created by cucumber"

  Scenario: Crate a public board
    Given I use the "trello" service and the "owner" account
    When I send a "POST" request to "/boards" with json body
    """
    {
    "name": "BoardCreate001 created by cucumber",
    "prefs_permissionLevel": "public"
    }
    """
    And I save the response as "P"
    Then I send a "GET" request to "/cards/{P.id}"
    And I validate the response contains "prefs_permissionLevel" equals "public"
    And I validate the response contains "name" equals "BoardCreate001 created by cucumber"