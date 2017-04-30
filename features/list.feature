Feature: List

  Scenario: list
    When I run `partoo list ../../spec/fixtures/files/testdata.par2`
    Then the output should match /test-0.data/
