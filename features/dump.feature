Feature: Dump

  Scenario: dump
    When I run `partoo dump ../../spec/fixtures/files/testdata.par2`
    Then the output should match /PAR2.*PKT/
