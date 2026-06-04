//
//  AuctionVM.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 22/04/26.
//

import Foundation
import FirebaseMessaging

class AuctionVM {
    var auctionDetails: AuctionDetails?
    fileprivate var teamsBidBalanceResponse: TeamBidBalanceResponse?
    internal var delegate: AuctionDelegate?
    
    internal var isAuctionViewerAdded: Bool = false
}

// MARK: AuctionDetails Helper
extension AuctionVM {
    
    var tournamentTotalBidPriceInCR: Int? {
        auctionDetails?.tournamentDetails?.tournamentTotalBidPriceInCR
    }
    
    var playerName: String {
        auctionDetails?.playerStats?.playerName ?? ""
    }
    var playerStats: String {
        guard let playerStats = auctionDetails?.playerStats else { return "" }
        return "M - \(playerStats.noOfMatches ?? 0), W -\(playerStats.noOfWins ?? 0), L - \(playerStats.noOfLosses ?? 0), D - \(playerStats.noOfDraws ?? 0), W% - \(playerStats.winPercentage ?? 0)%"
    }
    var potName: String {
        auctionDetails?.potPlayer?.potName ?? ""
    }
    
    var basePrice: String {
        "\(auctionDetails?.potPlayer?.basePrice ?? 0)"
    }
    
    var currentBid: String {
        "\(auctionDetails?.potPlayer?.bidPriceInCR ?? 0)"
    }
    
    var isAdmin: Bool {
        auctionDetails?.isAdmin == 1
    }
    
    var isCaptain: Bool {
        auctionDetails?.isCaptain == 1
    }
    
    var teamName: String {
        auctionDetails?.teamName ?? ""
    }
    
    var captainName: String {
        auctionDetails?.captainName ?? ""
    }
    
    var tournamentAuctionStatus: String {
        auctionDetails?.tournamentDetails?.tournamentAuctionStatus?.lowercased() ?? ""
    }
    
    var hasPlayer: Bool {
        auctionDetails?.potPlayer?.potPlayerID != nil
    }
    
    var currentPotPlayerID: Int? {
        auctionDetails?.potPlayer?.potPlayerID
    }
    
    var currentTeamID: Int?  {
        guard let teamID = auctionDetails?.potPlayer?.teamID, teamID > 0 else {
            return nil
        }
        return teamID
    }
    
    var playerBidPriceInCR: Int {
        auctionDetails?.potPlayer?.bidPriceInCR ?? 0
    }
    
    private var newBidTopic: String? {
        guard let id = auctionDetails?.tournamentDetails?.tournamentID, let code = auctionDetails?.tournamentDetails?.tournamentCode else { return nil }
        return "new_bid_\(id).\(code)"
    }
    
    private var skipTopic: String? {
        guard let id = auctionDetails?.tournamentDetails?.tournamentID, let code = auctionDetails?.tournamentDetails?.tournamentCode else { return nil }
        return "skip_\(id).\(code)"
    }
    
    private var soldTopic: String? {
        guard let id = auctionDetails?.tournamentDetails?.tournamentID, let code = auctionDetails?.tournamentDetails?.tournamentCode else { return nil }
        return "sold_\(id).\(code)"
    }
}

extension AuctionVM {
    func subscribeNotifications() {
        guard let newBidTopic, let skipTopic, let soldTopic else { return }

        Messaging.messaging().subscribe(toTopic: newBidTopic) { error in
          debugPrint("Subscribed to -->> \(newBidTopic)")
        }
        
        Messaging.messaging().subscribe(toTopic: skipTopic) { error in
          debugPrint("Subscribed to -->> \(skipTopic)")
        }
        
        Messaging.messaging().subscribe(toTopic: soldTopic) { error in
          debugPrint("Subscribed to -->> \(soldTopic)")
        }
    }
    func unsubscribeNotifications() {
        guard let newBidTopic, let skipTopic, let soldTopic else { return }
        
        Messaging.messaging().unsubscribe(fromTopic: newBidTopic) { error in
            debugPrint("Subscribed to -->> \(newBidTopic)")
        }
        
        Messaging.messaging().unsubscribe(fromTopic: skipTopic) { error in
            debugPrint("Subscribed to -->> \(skipTopic)")
        }
        
        Messaging.messaging().unsubscribe(fromTopic: soldTopic) { error in
            debugPrint("Subscribed to -->> \(soldTopic)")
        }
    }
}

//MARK: API Call
extension AuctionVM {
    
    internal func callAuctionDetailsAPI(tournamentID: Int, showLoader: Bool = true) {
        
        if showLoader == true {
            ActivityHUD().showProgressHUD()
        }
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID,
            "game_id" : 1
        ] as [String : Any]
        let detailUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.auctionDetails
        debugPrint(params)
        debugPrint(detailUrl)
        NetworkManager.shared.get(urlString: detailUrl, params: params, responseType: AuctionDetails.self) { [weak self] result in
            
            switch result {
            case .success(let responseObj):
                print(responseObj)
                self?.auctionDetails = responseObj
                self?.delegate?.showAuctionDetails()
                self?.subscribeNotifications()
            case .failure(let errorObj):
                print(errorObj)
                self?.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
//    internal func callTeamsBidBalanceAPI(tournamentID: Int) {
//        
//        ActivityHUD().showProgressHUD()
//        let params = [
//            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
//            "tournament_id" : tournamentID
//        ] as [String : Any]
//        let balanceUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.teamsBidBalance
//        debugPrint(params)
//        debugPrint(balanceUrl)
//        NetworkManager.shared.get(urlString: balanceUrl, params: params, responseType: TeamBidBalanceResponse.self) { result in
//            
//            switch result {
//            case .success(let responseObj):
//                print(responseObj)
//                self.teamsBidBalanceResponse = responseObj
//                self.delegate?.showTeamBidBalance()
//            case .failure(let errorObj):
//                print(errorObj)
//                self.delegate?.showAlertWith(error: errorObj)
//            }
//            
//        }
//    }
    
    internal func callStartAuctionAPI(tournamentID: Int, bidPrice: Int) {
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID,
            "bid_price" : bidPrice
        ] as [String : Any]
        let startAuctionUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.startAuction
        debugPrint(params)
        debugPrint(startAuctionUrl)
        NetworkManager.shared.post(urlString: startAuctionUrl, params: params, responseType: BasicNetworkModel.self) { [weak self] result in
            
            switch result {
            case .success(let responseObj):
                print(responseObj)
//                self.currentAction = .startAuction
//                self.actionResponse = responseObj
//                self.delegate?.auctionActionSuccess()
                self?.delegate?.startAuctionSuccess()
            case .failure(let errorObj):
                print(errorObj)
                self?.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    internal func callSubmitBidAPI(tournamentID: Int, potPlayerID: Int, bidPrice: Int) {
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID,
            "pot_player_id" : potPlayerID,
            "bid_price" : bidPrice
        ] as [String : Any]
        let submitBidUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.submitBid
        debugPrint(params)
        debugPrint(submitBidUrl)
        NetworkManager.shared.post(urlString: submitBidUrl, params: params, responseType: BasicNetworkModel.self) { [weak self] result in
            
            switch result {
            case .success(let responseObj):
                print(responseObj)
//                self.currentAction = .submitBid
//                self.actionResponse = responseObj
//                self.delegate?.auctionActionSuccess()
                self?.delegate?.submitBidSuccess()
            case .failure(let errorObj):
                print(errorObj)
                self?.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    internal func callSoldPlayerAPI(potPlayerID: Int, bidPrice: Int, teamID: Int) {
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "pot_player_id" : potPlayerID,
            "bid_price" : bidPrice,
            "team_id" : teamID
        ] as [String : Any]
        let soldPlayerUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.soldPlayer
        debugPrint(params)
        debugPrint(soldPlayerUrl)
        NetworkManager.shared.post(urlString: soldPlayerUrl, params: params, responseType: BasicNetworkModel.self) { [weak self] result in
            
            switch result {
            case .success(let responseObj):
                print(responseObj)
//                self.currentAction = .soldPlayer
//                self.actionResponse = responseObj
//                self.delegate?.auctionActionSuccess()
                self?.delegate?.soldPlayerSuccess(responseObj)
            case .failure(let errorObj):
                print(errorObj)
                self?.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    
    
    internal func callSkipPlayerAPI(potPlayerID: Int) {
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "pot_player_id" : potPlayerID
        ] as [String : Any]
        let skipPlayerUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.skipPlayer
        debugPrint(params)
        debugPrint(skipPlayerUrl)
        NetworkManager.shared.post(urlString: skipPlayerUrl, params: params, responseType: BasicNetworkModel.self) { [weak self] result in
            
            switch result {
            case .success(let responseObj):
                print(responseObj)
//                self.currentAction = .skipPlayer
//                self.actionResponse = responseObj
//                self.delegate?.auctionActionSuccess()
                self?.delegate?.skipPlayerSuccess()
            case .failure(let errorObj):
                print(errorObj)
                self?.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    internal func callAddAuctionViewerAPI(tournamentID: Int) {
        
        let params = [
            "tournament_id" : tournamentID,
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID)
        ] as [String : Any]
        let viewerUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.addAuctionViewer
        debugPrint(params)
        debugPrint(viewerUrl)
        NetworkManager.shared.post(urlString: viewerUrl, params: params, responseType: BasicNetworkModel.self) { [weak self] result in
            
            switch result {
            case .success(let responseObj):
                print(responseObj)
//                self.currentAction = .addAuctionViewer
//                self.actionResponse = responseObj
            case .failure(let errorObj):
                print(errorObj)
            }
            
        }
        
    }
    
}

//MARK: Model Fetch
extension AuctionVM {
    
    internal func getSelectedModelWith() -> AuctionDetails {
        return self.auctionDetails ?? .empty
    }
    
//    internal func getAuctionActionResponse() -> BasicNetworkModel? {
//        return self.actionResponse
//    }
    
    internal func getTeamsBidBalanceResponse() -> TeamBidBalanceResponse? {
        return self.teamsBidBalanceResponse
    }
    
//    internal func getSoldPlayersResponse() -> BasicNetworkModel? {
//        return self.soldPlayersResponse
//    }
    
//    internal func getCurrentAction() -> AuctionAction {
//        return self.currentAction
//    }
}
