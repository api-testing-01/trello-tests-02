#Feature: Lists
#  Background: User is in Board
#    Given I login as "owner"
#    When I open the board creation form
#    And I fill the board form with:
#      | title   | My Board for Lists |
#      | team    | No team     |
#      | privacy | Private     |
#      | image   | red       |
#    And I click cancel button in list form
#
#  Scenario: Add a list in board
#    When I click add a list button
#    And I set the list title "My First List"
#    Then I validate the list "My First List" is displayed
#
#  Scenario: Edit a list
#    Given I click add a list button
#    And I set the list title "My First List"
#    When I click the list name "My First List"
#    And I set a new list title "Edited list"
#    Then I validate the new title is "Edited list"
#
#  Scenario: Archive a List
#    Given I click add a list button
#    And I set the list title "My First List"
#    When I click the actions button in the list "My First List"
#    And I select the action list "Archive This List"
#    Then I validate the list named "My First List" is archived
#    And I click More in right sidebar menu
#    And I click Archived Items
#    And I type "My First List" in search field
#    And I click Switch to lists button
#    And I validate the "My First List" is displayed in the search results
#
#  Scenario: Move a List
#    Given I click add a list button
#    And I set the list title "My List1"
#    And I set the list title "My List2"
#    When I click the actions button in the list "My List1"
#    And I select the action list "Move List"
#    And I select the position "2"
#    Then I validate "My List2" is before "My List1"
#    And I click the actions button in the list "My List1"
#    And I select the action list "Move List"
#    And I validate the position "2" is displayed
#    And I click position
#    And I validate the position "2" is marked as current