//
//  PickerVC.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 12/05/25.
//

import UIKit

protocol PickerVCModel {
    func displayText() -> String
}

protocol PickerVCDelegate {
//    func didSelectItem(at index: Int)
    func view(_ view:PickerVC, didSelect item: Int)
}

class PickerVC: UIViewController {
    
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var containerView: UIView!
    
    var identifier: Int = -1
    
    var arrayItems: [PickerVCModel]!
    
    var delegate: PickerVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.containerView.backgroundColor = CustomColor.bg2
        self.containerView.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
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

// MARK: UIPickerViewDataSource
extension PickerVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayItems.count
    }
    
    
}

// MARK: UIPickerViewDelegate
extension PickerVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = arrayItems[row]
        return item.displayText()
    }
}

// MARK: IBAction UIButton
extension PickerVC {
    
    @IBAction func selectAction(_ sender: UIButton) {
        let selection = picker.selectedRow(inComponent: 0)
        delegate?.view(self, didSelect: selection)
//        delegate?.didSelectItem(at: selection)
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
