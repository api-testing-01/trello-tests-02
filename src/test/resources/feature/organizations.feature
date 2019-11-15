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

  Scenario: GET Organizations
    When I send a GET request to "/organizations/{O.id}"
    Then I validate the response has status code 200
    And I validate the response contains "displayName" equals "Test1"
    And I validate the response contains "website" equals "https://trello.com/"
    And I send a DELETE request to "/organizations/{O.id}"
    And I validate the response has status code 200
