Feature: Inspect

  Scenario: inspect creator
    When I run `partoo inspect creator ../../spec/fixtures/files/testdata.par2`
    Then the output should contain "Created by QuickPar 0.4"

  Scenario: inspect recovery-set-file-count
    When I run `partoo inspect recovery-set-file-count ../../spec/fixtures/files/testdata.par2`
    Then the output should contain "10"

  Scenario: inspect recovery-set-id
    When I run `partoo inspect recovery-set-id ../../spec/fixtures/files/testdata.par2`
    Then the output should contain "172626095358484736903154840814915262152"

  Scenario: inspect slice-size
    When I run `partoo inspect slice-size ../../spec/fixtures/files/testdata.par2`
    Then the output should contain "5376"

  Scenario: bogus inspect
    When I run `partoo inspect bogus ../../spec/fixtures/files/testdata.par2`
    Then the output should match /bogus is not one of/
