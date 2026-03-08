//
//  ForgotPasswordVC.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 05/03/26.
//

import UIKit

class ForgotPasswordVC: BaseVC {
    
    @IBOutlet var passTF: UITextField!
    @IBOutlet var cPassTF: UITextField!
    @IBOutlet var otpTF: UITextField!
    @IBOutlet var btnConfirm: UIButton!
    
    internal var email : String!
    
    var viewModel = ForgotPasswordVM() 

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setBackButton()
        
        self.passTF.aboveOverlayTheme(placeHolder: "Password")
        self.cPassTF.aboveOverlayTheme(placeHolder: "Confirm Password")
        self.otpTF.aboveOverlayTheme(placeHolder: "OTP")
        self.btnConfirm.setDefaultTheme(name: "Confirm")
        viewModel.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: IBAction UIButton
extension ForgotPasswordVC {
    @IBAction func confirmAction(_ sender: UIButton) {
        if validate() {
            let pass = passTF.text!.trim()
            let otp = otpTF.text!.trim()
            viewModel.conformNewPassword(email: email, password: pass, otp: otp)
        }
    }
    
    private func validate() -> Bool {
        
        var rc = true
        
        let pass = passTF.text!.trim()
        let cPass = cPassTF.text!.trim()
        let otp = otpTF.text!.trim()
        
        if pass.isEmpty ||
            cPass.isEmpty ||
            otp.isEmpty  {
            rc = false
            showAlertWith(msg: "Please fill all the fields")
        } else if pass != cPass {
            rc = false
            showAlertWith(msg: "Passwords do not match")
        } else if pass.range(of: "^[A-Za-z0-9]{4,25}$", options: .regularExpression) == nil {
            rc = false
            showAlertWith(msg: "Passwords should be 4 to 25 characters long and can contain numbers & alphabets only")
        }
        
        return rc
    }
}

// MARK: ForgotPasswordDelegate
extension ForgotPasswordVC: ForgotPasswordDelegate {
    
    func passwordResetSuccess() {
        DispatchQueue.main.async {
            ActivityHUD().dismissProgressHUD()
            self.popSuccessAlertWith(msg: "Password updated successfully.")
//            self.navigationController?.popViewController(animated: true)
        }
    }
}
