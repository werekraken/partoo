Feature: List

  Scenario: list with no arguments
    When I run `partoo list ../../spec/fixtures/files/testdata.par2`
    Then the output should match /test-0.data/
    And  the output should not match /0441ba6c84c58402dd4cec76865b3ffa/
    And  the output should not match /20c29458/
    And  the output should not match /65890/

  Scenario: list with --crc32
    When I run `partoo list --crc32 ../../spec/fixtures/files/testdata.par2`
    Then the output should match /test-0.data/
    And  the output should match /20c29458/
    And  the output should not match /0441ba6c84c58402dd4cec76865b3ffa/
    And  the output should not match /65890/

  Scenario: list with -c (short for --crc32)
    When I run `partoo list -c ../../spec/fixtures/files/testdata.par2`
    Then the output should match /test-0.data/
    And  the output should match /20c29458/
    And  the output should not match /0441ba6c84c58402dd4cec76865b3ffa/
    And  the output should not match /65890/

  Scenario: list with --md5
    When I run `partoo list --md5 ../../spec/fixtures/files/testdata.par2`
    Then the output should match /test-0.data/
    And  the output should not match /20c29458/
    And  the output should match /0441ba6c84c58402dd4cec76865b3ffa/
    And  the output should not match /65890/

  Scenario: list with -m (short for --md5)
    When I run `partoo list -m ../../spec/fixtures/files/testdata.par2`
    Then the output should match /test-0.data/
    And  the output should not match /20c29458/
    And  the output should match /0441ba6c84c58402dd4cec76865b3ffa/
    And  the output should not match /65890/

  Scenario: list with --size
    When I run `partoo list --size ../../spec/fixtures/files/testdata.par2`
    Then the output should match /test-0.data/
    And  the output should not match /20c29458/
    And  the output should not match /0441ba6c84c58402dd4cec76865b3ffa/
    And  the output should match /65890/

  Scenario: list with -s (short for --size)
    When I run `partoo list -s ../../spec/fixtures/files/testdata.par2`
    Then the output should match /test-0.data/
    And  the output should not match /20c29458/
    And  the output should not match /0441ba6c84c58402dd4cec76865b3ffa/
    And  the output should match /65890/

  Scenario: list with --long
    When I run `partoo list --long ../../spec/fixtures/files/testdata.par2`
    Then the output should match /test-0.data/
    And  the output should match /20c29458/
    And  the output should match /0441ba6c84c58402dd4cec76865b3ffa/
    And  the output should match /65890/

  Scenario: list with -l (short for --long)
    When I run `partoo list -l ../../spec/fixtures/files/testdata.par2`
    Then the output should match /test-0.data/
    And  the output should match /20c29458/
    And  the output should match /0441ba6c84c58402dd4cec76865b3ffa/
    And  the output should match /65890/
