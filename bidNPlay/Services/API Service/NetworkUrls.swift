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
    static let deleteUser = "/delete_user"
    static let forgotPassword = "/forgot_password" //POST
    static let updateNewPassword = "/update_new_password" //POST
    static let tournamentList = "/tournament_list"
    static let tournamentDetail = "/tournament_details"
    static let indvidualTournamentDetail = "/individual_tournament_details"
    static let join = "/join_tournament_by_code"
    static let playerList = "/tournament_players_list"
    static let teamList = "/tournament_teams_list"
    static let teamPlayerList = "/team_players"
    static let potList = "/tournament_pots_list"
    static let potPlayerList = "/tournament_pot_players"
    static let nonPotPlayerList = "/tournament_no_pot_players"
    static let addPlayersToPot = "/add_players_to_pot"
    static let createPot = "/add_tournament_player_pot"
    static let individualFixtureList = "/individual_fixtures_by_round"
    static let individualFixtureRoundsList = "/individual_tournament_fixture_rounds"
    
    static let createTournament = "/create_tournament"
    
    static let teamFixtureList = "/team_fixtures_by_round"
    static let teamSubFixtureList = "/sub_fixtures_list"
    static let teamTournamentFixtureRounds = "/team_tournament_fixture_rounds"
    
    static let teamTournamentTable = "/team_tournament_table"
    static let individualTournamentTable = "/individual_tournament_table"
    static let teamPlayerStats = "/tournament_player_stats"
    
    static let addTeamPlayerFixture = "/add_team_player_fixture"
    static let deleteTeamSubFixture = "/delete_team_sub_fixture"
    static let addSubFixtureScore = "/add_sub_fixture_score"
    
    static let profile = "/view_profile"
    static let register = "/register_user"
    static let otpVerify = "/verify_registration_otp"
    static let joinTournament = "/join_tournament"
    static let leaveTournament = "/leave_tournament"
    static let tournamentAddTeam = "/add_tournament_team"
    static let removeAsCaptain = "/remove_as_captain"
    
    // Auction Related
    static let auctionDetails = "/auction_details" // GET
    static let teamsBidBalance = "/teams_bid_balance" // GET
    static let startAuction = "/start_auction" // POST
    static let submitBid = "/submit_bid" // POST
    static let soldPlayer = "/sold_player" // POST
    static let auctionSoldPlayers = "/auction_sold_players" // GET
    static let skipPlayer = "/skip_player" // POST
    static let addAuctionViewer = "/add_auction_viewer" // POST
}
