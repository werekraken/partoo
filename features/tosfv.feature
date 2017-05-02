Feature: To SFV

  Scenario: tosfv
    When I run `partoo tosfv ../../spec/fixtures/files/testdata.par2`
    Then the output should match /test-0.data 20c29458\n/
