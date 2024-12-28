//
//  OTPVM.swift
//  bidNPlay
//
//  Created by Ashin Asok on 18/12/24.
//

import Foundation

class OTPVM{
    
    var delegate : LoginDelegate?
    
}

//MARK: Check inputs
extension OTPVM{
    
    internal func preludeCheckToRegisterAPI(name: String, email: String, password: String, countryCode: String, phone: String){
        let code = countryCode.replacingOccurrences(of: "+", with: "")
        let params : [String: Any] = [
            "name" : name,
            "email" : email,
            "phone" : phone,
            "country_code" : code,
            "password" : password
        ]
        self.callRegisterAPI(params: params)
    }
    
    internal func preludeCheckToLoginAPI(email: String, otp: String){
        
        if ValidationMethods().isValidEmail(email: email) == false{
            self.delegate?.showAlertWith(msg: "Enter valid email")
        }else if otp.replacingOccurrences(of: " ", with: "") == ""{
            self.delegate?.showAlertWith(msg: "Enter valid OTP")
        }else{
            self.callVerifyOTPAPI(email: email, otp: otp)
        }
        
    }
    
}

//MARK: Login API
extension OTPVM{
    
    // Register API is called as resend OTP
    private func callRegisterAPI(params: [String: Any]){
        
        ActivityHUD().showProgressHUD()
        let registerUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.register
        debugPrint(params)
        debugPrint(registerUrl)
        NetworkManager.shared.post(urlString: registerUrl, params: params, responseType: BasicNetworkModel.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.delegate?.resendOTPSuccess()
//                self.delegate?.registerSuccess()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    private func callVerifyOTPAPI(email: String, otp: String){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "email" : email,
            "otp" : otp
        ] as [String : Any]
        let verifyURL = APIURLs.baseUrl + APIURLs.api + APIURLs.otpVerify
        debugPrint(params)
        debugPrint(verifyURL)
        NetworkManager.shared.post(urlString: verifyURL, params: params, responseType: LoginModel.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.saveDataFrom(model: responseObj.user_details)
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    private func saveDataFrom(model: UserDetailsModel?){
        
        guard let model = model else{
            self.delegate?.popAlertWith(msg: "No data available")
            return
        }
        if let token = model.api_token{
            DefaultWrapper().setStringFor(Key: Keys.tokenID, Value: token)
        }
        if let fcm_token = model.fcm_token{
            DefaultWrapper().setStringFor(Key: Keys.fcm, Value: fcm_token)
        }
        if let user_id = model.user_id{
            DefaultWrapper().setIntFor(Key: Keys.userID, Value: user_id)
        }
        self.delegate?.loginSuccess()
        
    }
    
}
