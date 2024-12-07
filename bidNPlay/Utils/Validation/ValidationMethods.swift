//
//  ValidationMethods.swift
//  OpenLock
//
//  Created by SQT MAC PRO on 18/07/22.
//

import UIKit

//MARK: Main Class
class ValidationMethods: NSObject{
    
    
}

//MARK: Mobile Validation
extension ValidationMethods {
    
    internal func isValidPhone(phone:String) -> Bool {
        
        let phoneRegEx = "[0-9]{10,20}"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        if ((phoneTest.evaluate(with: phone) == true) && (phone.count == 10)){
            return true
        }else{
            return false
        }
        
    }
    
}

//MARK: Password Validation
extension ValidationMethods {
    
    internal func isValidPassword(password:String) -> Bool {
        
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        if ((trimmedPassword.count) >= 6){
            return true
        }else{
            return false
        }
        
    }
    
}

//MARK: Email Validation
extension ValidationMethods {
    
    internal func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

}

//MARK: Empty Fields
extension ValidationMethods{
    
    internal func isEmpty(text: String) -> Bool{
        
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedText.isEmpty
        
    }
    
}
