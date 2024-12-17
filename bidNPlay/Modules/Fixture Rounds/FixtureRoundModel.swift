//
//  FixtureRoundModel.swift
//  bidNPlay
//
//  Created by Ashin Asok on 17/12/24.
//

import Foundation

protocol GetRoundDetailDelegate{
    func selectedRound(round: Round)
}

protocol RoundDelegate: ErrorDelegate{
    func modelUpdated()
}

struct RoundsResponse: Decodable {
    
    let status: Bool
    let message: String
    let rounds: [Round]
    
}

struct Round: Decodable {
    
    let fixtureType: String
    let roundNo: Int
    let roundName: String
    
    enum CodingKeys: String, CodingKey {
        
        case fixtureType = "fixture_type"
        case roundNo = "round_no"
        case roundName = "round_name"
        
    }
    
}
