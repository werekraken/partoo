Feature: Verify

  Scenario: verify
    When I cd to "../../spec/fixtures/files"
    And  I run `partoo verify testdata.par2`
    Then the output should match /test-0.data true/
