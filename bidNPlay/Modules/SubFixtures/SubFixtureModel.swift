//
//  SubFixtureModel.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 26/02/25.
//

import Foundation

struct TeamSubFixtureModel: Decodable {
    let subFixtureID: Int
    let fixtureID: Int
    let homeUserID: Int
    let awayUserID: Int
    let homeUserGoals: Int?
    let awayUserGoals: Int?
    let subFixtureCreatedAt: String
    let subFixtureUpdatedAt: String
    let homeUserName: String
    let awayUserName: String
    let homeUserPhone: String
    let awayUserPhone: String
    let homeUserCountryCode: String
    let awayUserCountryCode: String
    
    enum CodingKeys: String, CodingKey {
        case subFixtureID = "sub_fixture_id"
        case fixtureID = "fixture_id"
        case homeUserID = "home_user_id"
        case awayUserID = "away_user_id"
        case homeUserGoals = "home_user_goals"
        case awayUserGoals = "away_user_goals"
        case subFixtureCreatedAt = "sub_fixture_created_at"
        case subFixtureUpdatedAt = "sub_fixture_updated_at"
        case homeUserName = "home_user_name"
        case awayUserName = "away_user_name"
        case homeUserPhone = "home_user_phone"
        case awayUserPhone = "away_user_phone"
        case homeUserCountryCode = "home_user_country_code"
        case awayUserCountryCode = "away_user_country_code"
    }
}

struct TeamSubFixtureResponse: Decodable {
    
    let status: Bool?
    let message: String?
    let fixtures: [TeamSubFixtureModel]
    let sub_fixture_creation_permission: Int
    let sub_fixture_score_permission: Int
}
