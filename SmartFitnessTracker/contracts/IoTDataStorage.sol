// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// IoT Data Storage adapted for Smart Fitness Monitoring
// Follows the general Week 3 template format

contract IoTDataStorage {

    struct IoTData {
        uint256 timestamp;
        string deviceId;     // Could be smartwatch ID or username
        string dataType;     // "Steps", "Calories", "Heart Rate"
        string dataValue;    // "10000", "340 kcal", "88 BPM"
    }

    uint256 public constant MAX_ENTRIES = 100;
    IoTData[] public dataRecords;
    address public owner;

    event DataStored(uint256 timestamp, string deviceId, string dataType, string dataValue);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Store fitness data (by the owner or an authorized device)
    function storeData(string memory _deviceId, string memory _dataType, string memory _dataValue) public onlyOwner {
        require(dataRecords.length < MAX_ENTRIES, "Storage limit reached");
        dataRecords.push(IoTData(block.timestamp, _deviceId, _dataType, _dataValue));
        emit DataStored(block.timestamp, _deviceId, _dataType, _dataValue);
    }

    function getTotalRecords() public view returns (uint256) {
        return dataRecords.length;
    }

    function getRecord(uint256 index) public view returns (uint256, string memory, string memory, string memory) {
        require(index < dataRecords.length, "Index out of bounds");
        IoTData memory record = dataRecords[index];
        return (record.timestamp, record.deviceId, record.dataType, record.dataValue);
    }
}
