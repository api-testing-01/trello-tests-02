Feature: Organizations PUT request

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/organizations" with json body
      """
      {
      "displayName": "TestPUT" ,
      "desc": "This team/organization will be updated from API",
      "name": "test" ,
      "website": "https://trello.com/"
       }
      """
    And I validate the response has status code 200
    And I save the response as "O"
    And I save the request endpoint for deleting

  @cleanData
  Scenario: Update an organization profile and settings
    When I send a "PUT" request to "/organizations/{O.id}" with json body
      """
        {
        "name": "testupdated" ,
        "displayName": "TestPUT_Updated" ,
        "desc": "Organization updated via API",
        "website": "https://trello.com/update",
        "prefs/permissionLevel" : "public"
         }
      """
    Then I validate the response has status code 200
    And I validate the response contains:
      | name          | testupdated                 |
      | displayName   | TestPUT_Updated             |
      | desc          | Organization updated via API|
      | website       | https://trello.com/update   |

    Given I send a "GET" request to "/organizations/{O.id}/prefs"
    Then I validate the response has status code 200
    And I validate the response contains "permissionLevel" equals "public"

    @cleanData
    Scenario: Add a new member to the organization and update their member type
      When I send a "PUT" request to "/organizations/{O.id}/members" with json body
      """
      {
      "idOrganization": "(O.id)" ,
      "email": "brayan.tester2017@gmail.com",
      "fullName": "brayan.tester2017"
       }
      """
      Then I validate the response has status code 200
      And I validate the response contains "members.fullName[1]" equals "brayan.tester2017"
      When I send a "PUT" request to "/organizations/{O.id}/members/brayantester20171" with json body
      """
      {
      "type": "admin"
       }
      """
      Then I validate the response has status code 200
      And I validate the response contains "memberships.memberType[1]" equals "admin"








