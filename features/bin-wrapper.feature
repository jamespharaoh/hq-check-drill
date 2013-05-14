Feature: Bin wrapper

  Scenario:

    Given a file "default.config":
      """
      <hq-check-drill-config/>
      """

    When I execute
      """
      hq-check-drill --config default.config
      """

    Then the exit status should be 0
    And the stdout should be:
      """
      Drill OK: no drills just now
      """
