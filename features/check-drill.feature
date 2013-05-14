Feature: Check if drill active

  Background:

    Given a file "default.config":
      """
      <hq-check-drill-config>
        <drill level="critical" message="this is a drill">
          <match template="%A" regex="Monday"/>
          <match template="%H" regex="09"/>
        </drill>
      </hq-check-drill-config>
      """

  Scenario: Critical drill active

    Given the time is 2013-05-13 09:30:00

    When I invoke check-drill --config default.config

    Then the exit status should be 2
    And the stdout should be:
      """
      Drill CRITICAL: this is a drill
      """

  Scenario: Wrong day

    Given the time is 2013-05-14 09:30:00

    When I invoke check-drill --config default.config

    Then the exit status should be 0
    And the stdout should be:
      """
      Drill OK: no drills just now
      """

  Scenario: Wrong time

    Given the time is 2013-05-13 10:30:00

    When I invoke check-drill --config default.config

    Then the exit status should be 0
    And the stdout should be:
      """
      Drill OK: no drills just now
      """
