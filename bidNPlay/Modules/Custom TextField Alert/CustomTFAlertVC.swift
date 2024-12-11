//
//  CustomTFAlertVC.swift
//  bidNPlay
//
//  Created by Ashin Asok on 11/12/24.
//

import UIKit

class CustomTFAlertVC: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var closeImage: UIImageView!
    @IBOutlet weak var closeHolderView: UIView!
    @IBOutlet weak var alertSubTitle: UILabel!
    @IBOutlet weak var alertTF: UITextField!
    @IBOutlet weak var alertButton: UIButton!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    internal var titleForAlert = ""
    internal var subTitleForAlert = ""
    internal var delegate: CustomTFDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupView()
    }

}

//MARK: Configure View
extension CustomTFAlertVC{
    
    fileprivate func configureView(){
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        self.holderView.layer.cornerRadius = 10
        self.holderView.backgroundColor = CustomColor.bg2
        
        self.alertTF.aboveOverlayTheme(placeHolder: "Tournament Code")
        self.alertTF.returnKeyType = .done
        self.alertTF.delegate = self
        
        self.alertButton.setDefaultTheme(name: "Done")
        self.alertButton.addTarget(
            self, action: #selector(doneAction), for: .touchUpInside
        )
        
        self.alertTitle.textColor = CustomColor.text
        self.alertTitle.font = UIFont().mediumFontWith(size: 18)
        
        self.alertSubTitle.textColor = CustomColor.text2
        self.alertSubTitle.font = UIFont().regularFontWith(size: 14)
        
        self.closeHolderView.layer.cornerRadius = self.closeHolderView.frame.height/2
        self.closeHolderView.backgroundColor = CustomColor.bg2
        
        self.closeButton.addTarget(
            self, action: #selector(closeView), for: .touchUpInside
        )
        
    }
    
    fileprivate func setupView(){
        
        self.alertTitle.text = self.titleForAlert
        self.alertSubTitle.text = self.subTitleForAlert
        
    }
    
}

//MARK: Button Actions
extension CustomTFAlertVC{
    
    @objc fileprivate func closeView(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc fileprivate func doneAction(){
        
        self.delegate?.getTextfieldEntry(value: (self.alertTF.text ?? ""))
        self.dismiss(animated: true)
        
    }
    
}

//MARK: Textfield Delegates
extension CustomTFAlertVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
}
