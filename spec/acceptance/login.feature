# encoding: utf-8

Feature: login flow
  Scenario: login flow
    Given visit root page
    Then redirect to login page
    Then there should be a login link
    When I clicked the login link
    Then login completes
    When visit login page
    Then redirect to root page
    Then there should be a logout link
    When I clicked the logout link
    Then logout completes

