//
//  NetworkUrls.swift
//  Ikin Fleet
//
//  Created by Ashin Asok on 13/06/23.
//

import Foundation

struct APIURLs{
    
    static let baseUrl = "https://dev.sectorqube.com/bidnplay/public"
    static let api = "/api"
    static let login = "/user_login"
    static let otp = "/verify_otp"
    static let tournamentList = "/tournament_list"
    static let tournamentDetail = "/tournament_details"
    static let indvidualTournamentDetail = "/individual_tournament_details"
    static let join = "/join_tournament_by_code"
    static let playerList = "/tournament_players_list"
    static let teamList = "/tournament_teams_list"
    static let teamPlayerList = "/team_players"
    static let potList = "/tournament_pots_list"
    static let potPlayerList = "/tournament_pot_players"
    static let individualFixtureList = "/individual_fixtures_by_round"
    static let individualFixtureRoundsList = "/individual_tournament_fixture_rounds"
    static let profile = "/view_profile"
    static let register = "/register_user"
    static let otpVerify = "/verify_registration_otp"
    
}
