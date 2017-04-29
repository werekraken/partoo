Feature: Core
  In order to work with par2 files
  As a CLI
  I want to be able to do operations

  Scenario: List
    When I run `partoo list some.par2`
    Then the output should contain "list of files from some.par2"
