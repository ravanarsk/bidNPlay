//
//  TournamentDetailVC.swift
//  bidNPlay
//
//  Created by Ashin Asok on 05/12/24.
//

import UIKit

class TournamentDetailVC: BaseVC {

    @IBOutlet weak var listTableView: UITableView!
    internal var viewTitle : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpView()
    }

}

//MARK: Init View
extension TournamentDetailVC{
    
    fileprivate func configureView(){
        
        self.setBackButton()
        self.listTableView.registerCells(names: ["DataCell"])
        self.listTableView.separatorStyle = .none
        self.listTableView.tableFooterView = UIView()
        self.listTableView.dataSource = self
        self.listTableView.delegate = self
        self.listTableView.showsVerticalScrollIndicator = false
        self.listTableView.showsHorizontalScrollIndicator = false
        
    }
    
    fileprivate func setUpView(){
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = self.viewTitle
        
    }
    
}

//MARK: Tableview delegates
extension TournamentDetailVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataCell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
}
