//
//  SubFixturesVM.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 24/02/25.
//

import Foundation

protocol SubFixturesDelegate: ErrorDelegate {
    func modelUpdated()
}

class SubFixturesVM{
    
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
                self.teamSubFixtureModel = responseObj.fixtures
                self.delegate?.modelUpdated()
            case .failure(let errorObj):
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
}
