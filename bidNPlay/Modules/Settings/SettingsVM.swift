//
//  SettingsVM.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 29/12/24.
//

import Foundation

class SettingsVM {
    var delegate: SettingsDelegate?
}

extension SettingsVM {
     func callDeleteAPI(){
        
        ActivityHUD().showProgressHUD()
        
        let user_id = DefaultWrapper().getIntFrom(Key: Keys.userID)
        
        let params = [
            "user_id" : user_id,
        ] as [String : Any]
        let deleteUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.deleteUser
        debugPrint(params)
        debugPrint(deleteUrl)
        
        NetworkManager.shared.delete(urlString: deleteUrl,
                                     params: params,
                                     responseType: DeleteUser.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.delegate?.userDeleteSuccess()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
        }
    }
}
