//
//  NetworkError.swift
//  Ikin Fleet
//
//  Created by Ashin Asok on 13/06/23.
//

import Foundation

struct NetworkError{
    
    static let urlError = NSError(
        domain: ErrorDomains.networkError,
        code: 600,
        userInfo: [
            NSLocalizedDescriptionKey: NetworkErrConstants.urlError
        ]
    )
    static let noData = NSError(
        domain: ErrorDomains.networkError,
        code: 601,
        userInfo: [
            NSLocalizedDescriptionKey: NetworkErrConstants.urlNoData
        ]
    )
    static let invalidUrl = NSError(
        domain: ErrorDomains.networkError,
        code: 602,
        userInfo: [
            NSLocalizedDescriptionKey: NetworkErrConstants.invalidUrl
        ]
    )
    static let invalidResponse = NSError(
        domain: ErrorDomains.networkError,
        code: 603,
        userInfo: [
            NSLocalizedDescriptionKey: NetworkErrConstants.invalidResponse
        ]
    )
    static let dataCorrupt = NSError(
        domain: ErrorDomains.networkError,
        code: 604,
        userInfo: [
            NSLocalizedDescriptionKey: NetworkErrConstants.dataCorrupt
        ]
    )
    
}
