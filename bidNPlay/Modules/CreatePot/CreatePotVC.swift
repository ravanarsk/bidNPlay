//
//  CreatePotVC.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 08/03/26.
//

import UIKit

class CreatePotVC: BaseVC {
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var basePriceTF: UITextField!
    @IBOutlet var switchAllowMultiple: UISwitch!
    @IBOutlet var btnConfirm: UIButton!
    
    private var viewModel = CreatePotVM()
    
    var tournamentID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setBackButton()
        
        nameTF.aboveOverlayTheme(placeHolder: "Name")
        basePriceTF.aboveOverlayTheme(placeHolder: "Base Price")
        btnConfirm.setDefaultTheme(name: "Create")
        
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
extension CreatePotVC {
    
    @IBAction func btnConfirmTapped(_ sender: UIButton) {
        guard validate() else { return }
        
        guard let tournamentID else { return }
        let name = nameTF.text?.trim() ?? ""
        let priceText = basePriceTF.text?.trim() ?? ""
        
        viewModel.createPot(tournamentID: "\(tournamentID)",
                            name: name,
                            basePrice: priceText,
                            allowMulti: switchAllowMultiple.isOn)
//        viewModel.createPot(tournamentID: tournamentID ?? 0, name: nameTF.text ?? "", basePrice: Double(basePriceTF.text ?? "0") ?? 0, allowMultipleBids: switchAllowMultiple.isOn) { (success) in
//            if success {
//                self.showAlertWith(msg: "Pot Created Successfully)") {
//                    _ = self.navigationController?.popViewController(animated: true)
//                }
//            }
//        }
    }
}

// MARK: CreatePotDelegate
extension CreatePotVC: CreatePotDelegate {
    func potCreated() {
        DispatchQueue.main.async {
            ActivityHUD().dismissProgressHUD()
            self.popSuccessAlertWith(msg: "Pot created.")
        }
    }
}

extension CreatePotVC {
    func validate() -> Bool {
        // Trimmed values for validation using trim()
        let name = nameTF.text?.trim() ?? ""
        let priceText = basePriceTF.text?.trim() ?? ""

        // Name must not be empty
        if name.isEmpty {
            showAlertWith(msg: "Please enter a name.")
            return false
        }

        // Price must be an integer only
        let integerRegex = "^[0-9]+$"
        let isInteger = NSPredicate(format: "SELF MATCHES %@", integerRegex).evaluate(with: priceText)

        if priceText.isEmpty || !isInteger {
            showAlertWith(msg: "Please enter a valid integer base price.")
            return false
        }

        return true
    }
}

