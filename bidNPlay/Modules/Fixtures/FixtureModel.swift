//
//  FixtureModel.swift
//  bidNPlay
//
//  Created by Ashin Asok on 17/12/24.
//

import Foundation

protocol FixtureDelegate: ErrorDelegate{
    func modelUpdated()
}

struct IndividualFixtureResponse: Decodable {
    
    let status: Bool?
    let message: String?
    let fixtures: [IndividualFixture]
    
}

struct IndividualFixture: Decodable {
    
    let individualFixtureId: Int
    let tournamentId: Int
    let fixtureType: String
    let homeUserId: Int
    let awayUserId: Int
    let homeUserGoals: Int?
    let awayUserGoals: Int?
    let homeUserName: String
    let awayUserName: String
    let homeUserPhone: String
    let awayUserPhone: String
    let homeUserCountryCode: String
    let awayUserCountryCode: String
    
    enum CodingKeys: String, CodingKey {
        
        case individualFixtureId = "individual_fixture_id"
        case tournamentId = "tournament_id"
        case fixtureType = "fixture_type"
        case homeUserId = "home_user_id"
        case awayUserId = "away_user_id"
        case homeUserGoals = "home_user_goals"
        case awayUserGoals = "away_user_goals"
        case homeUserName = "home_user_name"
        case awayUserName = "away_user_name"
        case homeUserPhone = "home_user_phone"
        case awayUserPhone = "away_user_phone"
        case homeUserCountryCode = "home_user_country_code"
        case awayUserCountryCode = "away_user_country_code"
        
    }
    
}
