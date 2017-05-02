Feature: To MD5

  Scenario: tomd5
    When I run `partoo tomd5 ../../spec/fixtures/files/testdata.par2`
    Then the output should match /0441ba6c84c58402dd4cec76865b3ffa  test-0.data\n/
