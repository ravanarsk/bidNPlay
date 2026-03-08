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
    let homeUserPhone: String?
    let awayUserPhone: String?
    let homeUserCountryCode: String?
    let awayUserCountryCode: String?
    
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

struct TeamFixtureResponse: Decodable {
    
    let status: Bool?
    let message: String?
    let fixtures: [TeamFixture]
}

struct TeamFixture: Decodable {
    
    let fixtureId: Int
    let tournamentId: Int
    let homeTeamId: Int
    let awayTeamId: Int
    let homeTeamPoints: Int
    let awayTeamPoints: Int
    let fixtureType: String
    let roundNo: Int
    let roundName: String
    let isVisible: Int
    let isFinished: Int
    let fixtureCreatedAt: String
    let fixtureUpdatedAt: String
    let addedToTable: Int
    let tournamentType: String
    let homeTeamName: String
    let awayTeamName: String
    
    enum CodingKeys: String, CodingKey {
        case fixtureId = "fixture_id"
        case tournamentId = "tournament_id"
        case homeTeamId = "home_team_id"
        case awayTeamId = "away_team_id"
        case homeTeamPoints = "home_team_points"
        case awayTeamPoints = "away_team_points"
        case fixtureType = "fixture_type"
        case roundNo = "round_no"
        case roundName = "round_name"
        case isVisible = "is_visible"
        case isFinished = "is_finished"
        case fixtureCreatedAt = "fixture_created_at"
        case fixtureUpdatedAt = "fixture_updated_at"
        case addedToTable = "added_to_table"
        case tournamentType = "tournament_type"
        case homeTeamName = "home_team_name"
        case awayTeamName = "away_team_name"
    }
    
//    enum CodingKeys: CodingKey {
//        case fixtureId
//        case tournamentId
//        case homeTeamId
//        case awayTeamId
//        case homeTeamPoints
//        case awayTeamPoints
//        case fixtureType
//        case roundNo
//        case roundName
//        case isVisible
//        case isFinished
//        case fixtureCreatedAt
//        case fixtureUpdatedAt
//        case addedToTable
//        case tournamentType
//        case homeTeamName
//        case awayTeamName
//    }
    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.fixtureId = try container.decodeIfPresent(Int.self, forKey: .fixtureId)
//        self.tournamentId = try container.decodeIfPresent(Int.self, forKey: .tournamentId)
//        self.homeTeamId = try container.decodeIfPresent(Int.self, forKey: .homeTeamId)
//        self.awayTeamId = try container.decodeIfPresent(Int.self, forKey: .awayTeamId)
//        self.homeTeamPoints = try container.decodeIfPresent(Int.self, forKey: .homeTeamPoints)
//        self.awayTeamPoints = try container.decodeIfPresent(Int.self, forKey: .awayTeamPoints)
//        self.fixtureType = try container.decodeIfPresent(String.self, forKey: .fixtureType)
//        self.roundNo = try container.decodeIfPresent(Int.self, forKey: .roundNo)
//        self.roundName = try container.decodeIfPresent(String.self, forKey: .roundName)
//        self.isVisible = try container.decodeIfPresent(Int.self, forKey: .isVisible)
//        self.isFinished = try container.decodeIfPresent(Int.self, forKey: .isFinished)
//        self.fixtureCreatedAt = try container.decodeIfPresent(String.self, forKey: .fixtureCreatedAt)
//        self.fixtureUpdatedAt = try container.decodeIfPresent(String.self, forKey: .fixtureUpdatedAt)
//        self.addedToTable = try container.decodeIfPresent(Int.self, forKey: .addedToTable)
//        self.tournamentType = try container.decodeIfPresent(String.self, forKey: .tournamentType)
//        self.homeTeamName = try container.decodeIfPresent(String.self, forKey: .homeTeamName)
//        self.awayTeamName = try container.decodeIfPresent(String.self, forKey: .awayTeamName)
//    }
}
