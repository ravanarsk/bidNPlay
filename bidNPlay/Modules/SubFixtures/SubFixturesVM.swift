//
//  SubFixturesVM.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 24/02/25.
//

import Foundation
import UIKit

protocol SubFixturesDelegate: ErrorDelegate {
    func modelUpdated()
    func reloadAPI()
}

class SubFixturesVM{
    var teamSubFixtureResponse: TeamSubFixtureResponse?
    var teamSubFixtureModel = [TeamSubFixtureModel]()
    var delegate: SubFixturesDelegate?
    
}

//MARK: Model fetch
extension SubFixturesVM{
    
    internal func getRowCount() -> Int {
        return self.teamSubFixtureModel.isEmpty ? 1 : self.teamSubFixtureModel.count
    }
    
    internal func getSubFixtureModel(index: Int) -> TeamSubFixtureModel {
        return self.teamSubFixtureModel[index]
    }
    
    internal func isEmpty() -> Bool{
        return self.teamSubFixtureModel.isEmpty
    }
    
    internal func getItem(at index: Int) -> TeamSubFixtureModel {
        return self.teamSubFixtureModel[index]
    }
}

extension SubFixturesVM {
    
    internal func getTeamSubFixtureList(fixtureID: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "fixture_id" : fixtureID,
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.teamSubFixtureList
        NetworkManager.shared.get(urlString: listUrl, params: params, responseType: TeamSubFixtureResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                self.teamSubFixtureResponse = responseObj
                self.teamSubFixtureModel = responseObj.fixtures
                self.delegate?.modelUpdated()
            case .failure(let errorObj):
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    internal func deleteFixtureAtIndex(index: Int){
//        self.teamSubFixtureModel.remove(at: index)
//        self.delegate?.modelUpdated()
        
        let item = self.getItem(at: index)
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "sub_fixture_id" : item.subFixtureID
        ] as [String : Any]
        let leaveUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.deleteTeamSubFixture
        debugPrint(params)
        debugPrint(leaveUrl)
        NetworkManager.shared.delete(urlString: leaveUrl, params: params, responseType: DeleteTeamSubFixtureResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
//                self.delegate?.reloadAPI()
                self.delegate?.reloadAPI()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
    }
    
    internal func addSubFixtureScoreAPI(for index: Int, homeUserGoal: Int, awayUserGoal: Int){
        
        let item = teamSubFixtureModel[index]
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "sub_fixture_id": item.subFixtureID,
            "home_user_goals" : homeUserGoal,
            "away_user_goals" : awayUserGoal
        ] as [String : Any]
        let leaveUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.addSubFixtureScore
        debugPrint(params)
        debugPrint(leaveUrl)
        NetworkManager.shared.post(urlString: leaveUrl, params: params, responseType: BasicNetworkModel.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.delegate?.reloadAPI()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    internal func openWhatsappForHomeUser(at index: Int) {
        let model = getItem(at: index)
        let phone = "\(model.homeUserCountryCode)\(model.homeUserPhone)"
        
        if !phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, let url = URL(string: "https://wa.me/\(phone)") {
            UIApplication.shared.open(url)
        }
    }
    internal func openWhatsappForAwayUser(at index: Int) {
        let model = getItem(at: index)
        let phone = "\(model.awayUserCountryCode)\(model.awayUserPhone)"
            
        if !phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, let url = URL(string: "https://wa.me/\(phone)") {
            UIApplication.shared.open(url)
        }
    }
}
