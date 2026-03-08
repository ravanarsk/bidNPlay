//
//  ForgotPasswordVM.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 05/03/26.
//

import Foundation

class ForgotPasswordVM {
    var delegate: ForgotPasswordDelegate?
    
    
}

 // MARK: APIs
extension ForgotPasswordVM {
    internal func conformNewPassword(email: String, password: String, otp: String){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "email":email,
            "password":password,
            "forgot_password_otp":otp,
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.updateNewPassword
        debugPrint(params)
        debugPrint(listUrl)
        NetworkManager.shared.post(urlString: listUrl, params: params, responseType: UpdatePasswordModel.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                
                if (responseObj.status ?? false) == true {
                    self.delegate?.passwordResetSuccess()
                } else {
                    self.delegate?.showAlertWith(msg: responseObj.message ?? "")
                }
                
//                self.response = responseObj
//                self.searchResults = self.response?.players ?? []
//                self.delegate?.refreshList()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
        }
    }
}
