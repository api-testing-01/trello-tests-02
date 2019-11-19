Feature: Members

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/organizations" with json body
      """
      {
      "displayName": "Lizzy's Organization" ,
      "desc": "This is a description",
      "name": "Lizzy O." ,
      "website": "http://lizzymendivil.com/"
       }
      """
    And I save the response as "O"
    And I send a "PUT" request to "/organizations{O.id}/members" with json body
    """
    {
    "id": "(O.id)",
    "email": "lizzymendivil@test.com",
    "fullName": "Lizzy Mendivil",
    "type": "normal"
    }
    """
    And I save the response as "M"

  @cleanData
  Scenario: POST Member Avatar
    When I send a "POST" request to "/members/{M.id}/avatar" with json body
    """
    {
    "file": "./avatars/lmendivil.jpg"
    }
    """
    Then I validate the response has status code 200
