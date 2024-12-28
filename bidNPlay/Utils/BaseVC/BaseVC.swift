//
//  BaseVC.swift
//  bidNPlay
//
//  Created by Ashin Asok on 02/12/24.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = CustomColor.bg
    }

}

//MARK: Success Alert
extension BaseVC{
    
    func showSuccessAlertWith(msg: String){
        
        ActivityHUD().dismissProgressHUD()
        let alertVC = UIAlertController(
            title: "",
            message: msg,
            preferredStyle: .alert
        )
        let doneAction = UIAlertAction(title: CommonConstants.done, style: .default) { action in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertVC.addAction(doneAction)
        self.present(alertVC, animated: true)
        
    }
    
    func popSuccessAlertWith(msg: String){
        
        ActivityHUD().dismissProgressHUD()
        let alertVC = UIAlertController(
            title: "",
            message: msg,
            preferredStyle: .alert
        )
        let doneAction = UIAlertAction(title: CommonConstants.done, style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alertVC.addAction(doneAction)
        self.present(alertVC, animated: true)
        
    }
    
    func showUpdateWith(msg: String){
        
        ActivityHUD().dismissProgressHUD()
        let alertVC = UIAlertController(
            title: "",
            message: msg,
            preferredStyle: .alert
        )
        let doneAction = UIAlertAction(title: CommonConstants.done, style: .default) { action in

        }
        alertVC.addAction(doneAction)
        self.present(alertVC, animated: true)
        
    }
    
}

//MARK: Back button
extension BaseVC{
    
    internal func setBackButton(isDetail : Bool = false){
        
        let button: UIButton = UIButton (type: .custom)
        if isDetail == false{
            button.setImage(
                UIImage(named: "arrowLeft"),for: .normal
            )
        }else{
            button.setImage(
                UIImage(named: "arrowLeftWhite"), for: .normal
            )
        }
        button.addTarget(
            self,
            action: #selector(backPressedAction),
            for: .touchUpInside
        )
        button.frame = CGRect(x: 0 , y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
    }
    
    @objc internal func backPressedAction(){
        
        self.navigationController?.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    internal func setBackButtonForModel(){
        
        let button: UIButton = UIButton (type: .custom)
        button.setImage(UIImage(named: "arrowLeft"), for: .normal)
        button.addTarget(
            self,
            action: #selector(backPressedForModel),
            for: .touchUpInside
        )
        button.frame = CGRect(x: 0 , y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
    }
    
    @objc internal func backPressedForModel(){
        
        self.navigationController?.dismiss(animated: true)
        
    }
    
}

//MARK: Logout Alert with action
extension BaseVC{
    
   internal func gotoLoginVC(){
        
        let rootViewController = LoginVC.loadFromNib()
        if let window = UIApplication.shared.windows.first{
            let navigationController = UINavigationController(
                rootViewController: rootViewController
            )
            window.rootViewController = navigationController
            DefaultWrapper().removeAll()
            window.makeKeyAndVisible()
        }

   }
    
}

//MARK: Error Delegates
extension BaseVC : ErrorDelegate{
    
    func showAlertWith(error: Error){
        
        ActivityHUD().dismissProgressHUD()
        var msg = ""
        if let errorCode = (error as NSError).code as? Int {
            msg = error.localizedDescription + " (\(errorCode))"
        }else{
            msg = error.localizedDescription
        }
        let alertVC = UIAlertController(
            title: CommonConstants.errorTitle,
            message: msg,
            preferredStyle: .alert
        )
        let doneAction = UIAlertAction(
            title: CommonConstants.done, style: .default
        )
        alertVC.addAction(doneAction)
        if Thread.isMainThread {
            self.present(alertVC, animated: true)
        }else{
            DispatchQueue.main.sync {
                self.present(alertVC, animated: true)
            }
        }
        
    }
    
    func showAlertWith(msg: String) {
        ActivityHUD().dismissProgressHUD()
        let alertVC = UIAlertController(
            title: CommonConstants.errorTitle,
            message: msg,
            preferredStyle: .alert
        )
        let doneAction = UIAlertAction(
            title: CommonConstants.done, style: .default
        ) { action in
//            self.navigationController?.popViewController(animated: true)
        }
        alertVC.addAction(doneAction)
        self.present(alertVC, animated: true)
    }
    
    func popAlertWith(msg: String){
        
        ActivityHUD().dismissProgressHUD()
        let alertVC = UIAlertController(
            title: CommonConstants.errorTitle,
            message: msg,
            preferredStyle: .alert
        )
        let doneAction = UIAlertAction(
            title: CommonConstants.done, style: .default
        ) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alertVC.addAction(doneAction)
        self.present(alertVC, animated: true)
        
    }
    
    func invalidToken() {
        
        ActivityHUD().dismissProgressHUD()
        DispatchQueue.main.sync {
            self.gotoLoginVC()
        }
        
    }
    
}
