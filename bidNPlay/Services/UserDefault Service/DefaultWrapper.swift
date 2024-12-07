//
//  DefaultWrapper.swift
//  SmartLock-SQT
//
//  Created by SQT MAC PRO on 06/09/22.
//

import UIKit

class DefaultWrapper : NSObject{
    
    fileprivate let defaults = UserDefaults.standard
    
}

//MARK: String value getter and setter
extension DefaultWrapper {
    
    internal func setStringFor(Key: String , Value: String){
        
        defaults.set(Value, forKey: Key)
        defaults.synchronize()
        
    }
    
    internal func getStringFrom(Key: String) -> String{
        
        if let value = defaults.string(forKey: Key){
            return value
        }else{
            return ""
        }
        
    }
    
    internal func getConditionalStringFrom(Key: String) -> String?{
        
        if let value = defaults.string(forKey: Key){
            return value
        }else{
            return nil
        }
        
    }
    
}

//MARK: Int value getter and setter
extension DefaultWrapper{
    
    internal func setIntFor(Key: String , Value: Int){
        
        defaults.set(Value, forKey: Key)
        defaults.synchronize()
        
    }
    
    internal func getIntFrom(Key: String) -> Int{
        
        let value = defaults.integer(forKey: Key)
        return value
        
    }
    
}

//MARK: Bool value getter and setter
extension DefaultWrapper{
    
    internal func setBoolFor(Key: String , Value: Bool){
        
        defaults.set(Value, forKey: Key)
        defaults.synchronize()
        
    }
    
    internal func getBoolFrom(Key: String) -> Bool{
        
        let value = defaults.bool(forKey: Key)
        return value
        
    }
    
}

//MARK: Remove all stored values
extension DefaultWrapper{
    
    internal func removeAll(){
        
        let permission = self.getBoolFrom(Key: Keys.bioPermission)
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
        self.setBoolFor(Key: Keys.bioPermission, Value: permission)
        
    }
    
    internal func remove(key: String){
        
        defaults.removeObject(forKey: key)
        defaults.synchronize()
        
    }
    
}
