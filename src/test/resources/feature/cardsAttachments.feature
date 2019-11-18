Feature: CardsAttachments

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
    """
    {
    "name": "Board [Attachment TC]"
    }
    """
    And I save the response as "B"
    And I save the request endpoint for deleting
    And I send a "POST" request to "/lists" with json body
    """
    {
    "name": "List [Attachment TC]",
    "idBoard": "(B.id)"
    }
    """
    And I save the response as "L"
    And I send a "POST" request to "/cards" with json body
    """
    {
    "name": "Card [Attachment TC]",
    "idList": "(L.id)"
    }
    """
    And I save the response as "C"

  @cleanData
  Scenario: POST Card Attachment
    When I send a "POST" request to "/cards/{C.id}/attachments" with json body
    """
    {
    "id": "(C.id)",
    "name":"test.pdf",
    "url":"https://trello-attachments.s3.amazonaws.com/5bbcda7a58bba713f1b18c10/5bbce0dbcac3a880704bc097/eca30e0de0a07563d870cd25d30e6fcb/test.pdf",
    }
    """
    Then I save the response as "A"
    And I validate the response has status code 200
    And I validate the response contains "name" equals "test.pdf"

  @cleanData
  Scenario: GET Card Attachment
    When I send a GET request to "/cards/{C.id}/attachments"
    Then I validate the response has status code 200

  @CleanData
  Scenario: Delete Card Attachment
    When I send a "DELETE" request to "/cards/{C.id}/attachments/{A.idAttachment}"
    Then I validate the response has status code 200
