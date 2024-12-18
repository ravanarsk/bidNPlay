//
//  ProfileVC.swift
//  bidNPlay
//
//  Created by Ashin Asok on 18/12/24.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    
    fileprivate var profileVM = ProfileVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileVM.callProfileAPI()
    }

}
