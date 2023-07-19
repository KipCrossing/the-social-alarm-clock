// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../library/AlarmSchedule.sol";

contract AlarmScheduleMock {
    using AlarmSchedule for AlarmSchedule.Schedule;

    AlarmSchedule.Schedule schedule;

    function init(
        uint alarmTime,
        uint8[] memory alarmDaysOfWeek,
        uint submissionWindow,
        int timezoneOffset
    ) public {
        schedule.init(
            alarmTime,
            alarmDaysOfWeek,
            submissionWindow,
            timezoneOffset
        );
        schedule.start();
    }

    function entries() public view returns (uint256) {
        return schedule.entries();
    }

    function missedDeadlines() public view returns (uint256) {
        return schedule.missedDeadlines();
    }

    function timeToNextDeadline() public view returns (uint256) {
        return schedule.timeToNextDeadline();
    }

    function nextDeadlineTimestamp() public view returns (uint) {
        return schedule.nextDeadlineTimestamp();
    }

    function inSubmissionWindow() public view returns (bool) {
        return schedule.inSubmissionWindow();
    }

    function recordEntry() public {
        return schedule.recordEntry();
    }

    function _dayOfWeek(int offset) public view returns (uint256) {
        uint offsetTime = AlarmSchedule._offsetTimestamp(
            block.timestamp,
            offset
        );
        return AlarmSchedule._dayOfWeek(offsetTime);
    }

    function _nextAlarmDay(uint8 curDay) public view returns (uint256) {
        return schedule._nextAlarmDay(curDay);
    }
}
