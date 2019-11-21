Feature: Delete Organization cases
  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/organizations" with json body
      """
      {
      "displayName": "OrganizationToDelete" ,
      "desc": "Creating from API [PUT]",
      "website": "https://trello.com/delete"
       }
      """
    And I validate the response has status code 200
    And I save the response as "O"
    And I save the request endpoint for deleting


  Scenario: Delete an specific organization

    When I send a "DELETE" request to "/organizations/{O.id}"
    Then I validate the response has status code 200
    And I send a "GET" request to "/organizations/{O.id}"
    Then I validate the response has status code 404

  @cleanData
  Scenario: Remove a member from a team
    Given I send a "PUT" request to "/organizations/{O.id}/members" with json body
      """
      {
      "idOrganization": "(O.id)" ,
      "email": "brayan.tester2017@gmail.com",
      "fullName": "brayan.tester2017"
       }
      """
    And I validate the response has status code 200
    When I send a "DELETE" request to "/organizations/{O.id}/members/5dd31dc1ee750d71a60850e1"
    Then I validate the response has status code 200

  @cleanData
  Scenario: Remove a member from organization and board (Negative Case - Available only for Business Class)
    Given I send a "PUT" request to "/organizations/{O.id}/members" with json body
      """
      {
      "idOrganization": "(O.id)" ,
      "email": "brayan.tester2017@gmail.com",
      "fullName": "brayan.tester2017"
       }
      """
    And I validate the response has status code 200
    Given I send a "POST" request to "/boards" with json body
        """
        {
        "name": "boardLinkToOrganization" ,
        "idOrganization": "(O.id)"
         }
        """
    And I validate the response has status code 200
    And I save the response as "B"
    Given I send a "PUT" request to "/boards/{B.id}/members/5dd31dc1ee750d71a60850e1" with json body
     """
      {
      "type": "normal"
       }
      """
    And I validate the response has status code 200
    When I send a "DELETE" request to "/organizations/{O.id}/members/5dd31dc1ee750d71a60850e1/all"
    Then I validate the response has status code 401
    And I validate the response contains "message" equals "Removal feature not enabled"
    And I send a "DELETE" request to "/boards/{B.id}"
    And I validate the response has status code 200








    
    
    

