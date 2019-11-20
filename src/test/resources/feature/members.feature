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
    And I send a "PUT" request to "/organizations/{O.id}/members" with json body
    """
    {
    "id": "(O.id)",
    "email": "lizzymendivil@test.com",
    "fullName": "Lizzy Mendivil",
    "type": "normal"
    }
    """
    And I save the response as "M"

  #@cleanData
  #Scenario: POST Member Avatar
    #When I send a "POST" request to "/members/{M.id}/avatar" with json body
    #"""
    #{
    #"file": "./avatars/lmendivil.jpg"
    #}
    #"""
    #Then I validate the response has status code 200

   @cleanData
   Scenario: PUT /members/{id}
    When I send a "PUT" request to "/members/{M.members[0].id}" with json body
    """
    {
    "fullName":"Lizzy Amabel Mendivil Bejarano",
    "initials": "LAMB",
    "username": "lizz",
    "bio": "This is a bio"
    }
    """
    Then I validate the response has status code 200
    And I validate the response contains "initials" equals "LAMB"

   @cleanData
   Scenario: GET /members/{id}/boards
    When I send a "POST" request to "/boards" with json body
    """
    {
    "name": "My Board" ,
    "idOrganization": "(O.id)"
    }
    """
    And I validate the response has status code 200
    And I save the response as "B"
    And I send a "PUT" request to "/boards/{B.id}/members/{M.id}" with json body
    """
    {
    "type": "normal" ,
    "allowBillableGuest": "true"
    }
    """
    And I send a "GET" request to "/members/{M.id}/boards"
    Then I validate the response has status code 200
    And I validate the response contains "name" equals "My Board"
