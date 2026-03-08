//
//  FixtureVM.swift
//  bidNPlay
//
//  Created by Ashin Asok on 17/12/24.
//

import Foundation
import UIKit

class FixtureVM{
    
    var individualFixtureModel = [IndividualFixture]()
    var teamFixtureModel = [TeamFixture]()
    var delegate: FixtureDelegate?
    var isIndividual : Bool = false
    
}

extension FixtureVM {
    internal func openWhatsappForLeftIndividual(at index: Int) {
        let model = getIndividualModel(index: index)
        let phone = "\(model.homeUserCountryCode)\(model.homeUserPhone)"
        
        if !phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, let url = URL(string: "https://wa.me/\(phone)") {
            UIApplication.shared.open(url)
        }
    }
    
    internal func openWhatsappForRightIndividual(at index: Int) {
        let model = getIndividualModel(index: index)
        let phone = "\(model.awayUserCountryCode)\(model.awayUserPhone)"
        
        if !phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, let url = URL(string: "https://wa.me/\(phone)") {
            UIApplication.shared.open(url)
        }
    }
    
    
}

//MARK: API Calls
extension FixtureVM{
    
    internal func getIndividualFixtureList(tournamentID: Int, roundNo: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID,
            "round_no" : roundNo
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.individualFixtureList
        NetworkManager.shared.get(urlString: listUrl, params: params, responseType: IndividualFixtureResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                self.individualFixtureModel = responseObj.fixtures
                self.delegate?.modelUpdated()
            case .failure(let errorObj):
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    internal func getTeamFixtureList(tournamentID: Int, roundNo: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID,
            "round_no" : roundNo
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.teamFixtureList
        NetworkManager.shared.get(urlString: listUrl, params: params, responseType: TeamFixtureResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                self.teamFixtureModel = responseObj.fixtures
                self.delegate?.modelUpdated()
            case .failure(let errorObj):
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
}

//MARK: Model fetch
extension FixtureVM{
    
    internal func getRowCount() -> Int {
        
        if self.isIndividual == true{ // Individual Fixture
            return self.individualFixtureModel.isEmpty ? 1 : self.individualFixtureModel.count
        } else{ // Team Fixture
            return self.teamFixtureModel.isEmpty ? 1 : self.teamFixtureModel.count
        }
        
    }
    
    internal func getIndividualModel(index: Int) -> IndividualFixture {
        return self.individualFixtureModel[index]
    }
    
    internal func getTeamModel(index: Int) -> TeamFixture {
        return self.teamFixtureModel[index]
    }
    
    internal func isEmpty() -> Bool{
        if self.isIndividual == true{
            return self.individualFixtureModel.isEmpty
        }else{
            return self.teamFixtureModel.isEmpty
        }
    }
}
