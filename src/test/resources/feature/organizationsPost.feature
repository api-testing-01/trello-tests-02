Feature: Organization Post

  Background:
    Given I use the "trello" service and the "owner" account
    When I send a "POST" request to "/organizations" with json body
      """
      {
      "displayName": "Test1PUT" ,
      "desc": "Creating from API [PUT]",
      "website": "https://trello.com/"
       }
      """
    And I validate the response has status code 200
    And I save the response as "OP"
    And I save the request endpoint for deleting

  @cleanData
  Scenario: Organization creation
    Then I validate the response contains:
      | displayName  | Test1PUT  |
      | desc   | Creating from API [PUT]|
      | website  | https://trello.com/|

  @cleanData
  Scenario: Create a new collection in a team (Corner case)
    When I send a "POST" request to "organizations/{OP.id}/tags" with json body
      """
        {
        "name": "collection1"
        }
      """
    Then I validate the response has status code 403

  @cleanData
  Scenario: Kick off CSV export for an organization (Corner case)
    When I send a "POST" request to "organizations/{OP.id}/exports" with json body
      """
        {
        "attachments": "true"
        }
      """
    Then I validate the response has status code 401





