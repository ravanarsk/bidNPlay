//
//  ErrorStrings.swift
//  Ikin Fleet
//
//  Created by SQT MAC PRO on 13/06/23.
//

import Foundation

struct ErrorDomains{
    
    static let networkError = "com.sqt.Ikin-Fleet.network"
    static let appError = "com.sqt.Ikin-Fleet.app"
    
}

struct NetworkErrConstants{
    
    static let urlError = "URL broken or could not be found"
    static let urlNoData = "No data received from server"
    static let invalidUrl = "URL provided is invalid"
    static let invalidResponse = "The response received from server is invalid"
    static let unknownServer = "Unknown server error"
    static let dataCorrupt = "Server data corrupted"
    
}

struct ValidationErrConstants{
    
    static let incorrectUsername = "Please enter valid Email ID"
    static let noUsername = "Please enter valid Email ID to continue"
    static let otpError = "Please enter valid OTP"
    static let issueError = "Subject title cannot be empty"
    static let selectDeviceError = "Please select a device"
    static let issueDescError = "Issue description cannot be empty"
    static let noDeviceError = "No devices present in your account. Please add a device to proceed."
    static let vehicleError = "Vehicle name cannot be empty"
    static let drivePhoneError = "Driver phone number cannot be empty"
    static let dateError = "Date & Time cannot be empty"
    static let locationError = "Location cannot be empty"
    static let appUserName = "Please enter valid App user name"
    static let appUserNumber = "Please enter valid App user number"
    static let lockUnlock = "Device cannot be unlocked"
    static let emptyString = "Search string empty. Please try again with another keyword."
    
}
