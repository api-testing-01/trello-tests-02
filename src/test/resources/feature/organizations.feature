Feature: Organizations

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/organizations" with json body
      """
      {
      "displayName": "Test1" ,
      "desc": "This is team description",
      "name": "test" ,
      "website": "https://trello.com/"
       }
      """
    And I validate the response has status code 200
    And I save the response as "O"
    And I save the request endpoint for deleting

  @cleanData
  Scenario: GET Organizations
    When I send a "GET" request to "/organizations/{O.id}"
    Then I validate the response has status code 200
    And I validate the response contains "displayName" equals "Test1"
    And I validate the response contains "website" equals "https://trello.com/"

  @cleanData
  Scenario: GET Organization members
    Given I send a "PUT" request to "/organizations/{O.id}/members" with json body
      """
      {
      "idOrganization": "(O.id)" ,
      "email": "brayan.tester2017@gmail.com",
      "fullName": "brayan.tester2017"
       }
      """
    When I send a "GET" request to "/organizations/{O.id}/members"
    Then I validate the response has status code 200

  @cleanData
  Scenario: GET Organization boards
    Given I send a "POST" request to "/boards" with json body
        """
        {
        "name": "boardLinkToOrganization" ,
        "idOrganization": "(O.id)"
         }
        """
    And I validate the response has status code 200
    And I save the response as "B"
    When I send a "GET" request to "/organizations/{O.id}/boards"
    Then I validate the response has status code 200
    And I validate the response contains "name" equals "[boardLinkToOrganization]"
    And I send a "DELETE" request to "/boards/{B.id}"
    And I validate the response has status code 200
