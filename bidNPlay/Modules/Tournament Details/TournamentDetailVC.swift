//
//  TournamentDetailVC.swift
//  bidNPlay
//
//  Created by Ashin Asok on 05/12/24.
//

import UIKit

class TournamentDetailVC: BaseVC {

    @IBOutlet weak var listTableView: UITableView!
    internal var tournamentID : Int?
    fileprivate var detailVM = TournamentDetailVM()
    
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
        self.listTableView.registerCells(names:[
            "DataCell","HeaderCell", "BasicInfoCell","PlayerInfoCell"
        ])
        self.listTableView.backgroundColor = CustomColor.bg
        self.listTableView.separatorStyle = .none
        self.listTableView.tableFooterView = UIView()
        self.listTableView.showsVerticalScrollIndicator = false
        self.listTableView.showsHorizontalScrollIndicator = false
        
    }
    
    fileprivate func setUpView(){
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "Details"
        self.listTableView.dataSource = nil
        self.listTableView.delegate = nil
        self.callDetailAPI()
        
    }
    
}

//MARK: API Call
extension TournamentDetailVC{
    
    fileprivate func callDetailAPI(){
        
        self.detailVM.delegate = self
        if let id = self.tournamentID{
            self.detailVM.callTournamentDetailAPI(tournamentID: id)
        }
        
    }
    
}

//MARK: View Model Delegates
extension TournamentDetailVC: TournamentDetailDelegate{
    
    func showTournamentDetails() {
        
        DispatchQueue.main.async {
            ActivityHUD().dismissProgressHUD()
            if self.listTableView.delegate == nil || self.listTableView.dataSource == nil{
                self.listTableView.dataSource = self
                self.listTableView.delegate = self
            }
            self.listTableView.reloadData()
        }
        
    }
    
}

//MARK: Tableview delegates
extension TournamentDetailVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.detailVM.getSelectedModelWith()
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            cell.setUpCell(model: model)
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataCell
            cell.setUpCell(model: model, index: indexPath.row)
            return cell
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInfoCell", for: indexPath) as! BasicInfoCell
            cell.setUpCell(model: model)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerInfoCell", for: indexPath) as! PlayerInfoCell
            cell.setupCell(model: model)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 || indexPath.row == 1{
            return UITableView.automaticDimension
        }else if indexPath.row == 2{
            return 340
        }
        return 190
        
    }
    
}
