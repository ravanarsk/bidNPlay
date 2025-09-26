//
//  CreateTournamentModel.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 24/09/25.
//

import Foundation

protocol CreateTournament {
    
}

enum TournamentType: String, Codable, CaseIterable {
    case team = "Team_woa"
    case teamWithAuction = "Team"
    case individual = "Individual"
    
    var name: String {
        switch self {
        case .team:
            return "Team"
        case .teamWithAuction:
            return "Team - with auction"
        case .individual:
            return "Individual"
        }
    }
}

enum FixtureType: String, Codable, CaseIterable {
    case league = "round_robin"
    case knockout = "knockout"
    
    var name: String {
        switch self {
        case .league:
            return "League"
        case .knockout:
            return "Knockout"
        }
    }
}

let TeamCount = [2,4,8,16,32,64,128]
let PlayerCount = [2,4,8,16,32,64,128]
