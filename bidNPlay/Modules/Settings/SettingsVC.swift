//
//  SettingsVC.swift
//  bidNPlay
//
//  Created by Ashin Asok on 04/12/24.
//

import UIKit
import SafariServices

class SettingsVC: BaseVC {

    @IBOutlet weak var listTableView: UITableView!
    
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
extension SettingsVC{
    
    fileprivate func configureView(){
        
        self.listTableView.backgroundColor = CustomColor.bg
        self.listTableView.registerCells(names: [
            "RoundCell","EmptyListCell"
        ])
        self.listTableView.tableFooterView = UIView()
        self.listTableView.separatorStyle = .none
        self.listTableView.showsVerticalScrollIndicator = false
        self.listTableView.showsHorizontalScrollIndicator = false
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
    }
    
    fileprivate func setupView(){
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.title = "Settings"
        self.listTableView.reloadData()
        
    }
    
}

//MARK: Tableview delegates
extension SettingsVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoundCell", for: indexPath) as! RoundCell
        cell.setSettingsCell(index: indexPath.row)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return 0
        }
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            self.gotoProfileView()
        }else if indexPath.row == 1{
            self.openURLInSafariController("https://dev.sectorqube.com/bidnplay/public/api/terms_conditions")
        }else if indexPath.row == 2{
            self.openURLInSafariController("https://dev.sectorqube.com/bidnplay/public/api/privacy_policy")
        }else{
            self.logoutAlert()
        }
        
    }
    
}

//MARK: Segue to other views
extension SettingsVC{
    
    fileprivate func gotoProfileView(){
        
        let vc = ProfileVC.loadFromNib()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

//MARK: Open url
extension SettingsVC{
    
    func openURLInSafariController(_ urlString: String) {
        
        guard let url = URL(string: urlString) else {
            self.showUpdateWith(msg: "Invalid URL: \(urlString)")
            return
        }

        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemBlue
        self.present(safariVC, animated: true, completion: nil)
        
    }
    
}

//MARK: Logout
extension SettingsVC{
    
    fileprivate func logoutAlert(){
        
        let alertVC = UIAlertController(
            title: "Logout?",
            message: "Do you wish to logout from this account?",
            preferredStyle: .alert
        )
        let yesAction = UIAlertAction(
            title: "Yes", style: .default
        ) { action in
            self.gotoLoginVC()
        }
        let noAction = UIAlertAction(title: "No", style: .cancel)
        alertVC.addAction(yesAction)
        alertVC.addAction(noAction)
        self.present(alertVC, animated: true)
        
    }
    
}
