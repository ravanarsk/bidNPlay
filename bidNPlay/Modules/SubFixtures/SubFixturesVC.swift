//
//  SubFixturesVC.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 24/02/25.
//

import UIKit

class SubFixturesVC: BaseVC {
    
    @IBOutlet weak var listTableView: UITableView!
    
    internal var fixtureID : Int?
    internal var teamFixture: TeamFixture?
    
    fileprivate let fixtureVM = SubFixturesVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureCell()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupCell()
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


//MARK: Tableview Delegates
extension SubFixturesVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fixtureVM.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.fixtureVM.isEmpty() == true{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyListCell", for: indexPath) as! EmptyListCell
            cell.messageLabel.text = "List Empty"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubFixtureCell", for: indexPath) as! SubFixtureCell
            
            let model = self.fixtureVM.getSubFixtureModel(index: indexPath.row)
            cell.setTeamSubFixtureCell(model: model)
            cell.delegate = self
            
            if let permission = fixtureVM.teamSubFixtureResponse?.sub_fixture_score_permission, permission == 1 {
                cell.enableUpdate(true)
            } else {
                cell.enableUpdate(false)
            }
            
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.fixtureVM.isEmpty(){
            return self.listTableView.frame.height
        }else{
//            return 120
            return UITableView.automaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if let permission = fixtureVM.teamSubFixtureResponse?.sub_fixture_score_permission, permission == 1 {
            return .delete
        } else {
            return .none
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            deleteFixture(for: indexPath.row)
        }
    }
    
}

extension SubFixturesVC {
    fileprivate func configureCell(){
        self.listTableView.backgroundColor = CustomColor.bg
        self.listTableView.registerCells(names: [
            "SubFixtureCell","EmptyListCell"
        ])
        self.listTableView.tableFooterView = UIView()
        self.listTableView.separatorStyle = .none
        self.listTableView.showsVerticalScrollIndicator = false
        self.listTableView.showsHorizontalScrollIndicator = false
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
    }
    
    fileprivate func setupCell(){
        
        self.setBackButton()
        self.setAddBtn()
        self.navigationItem.title = "Sub Fixture"
        self.fixtureVM.delegate = self
        
        
        guard let fixtureID = self.fixtureID else {
            return
        }
        self.fixtureVM.getTeamSubFixtureList(fixtureID: fixtureID)
        
    }
    
    private func setAddBtn(){
        
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle"),
            style: .done,
            target: self,
            action: #selector(addFixtureAction)
        )
        barButtonItem.tintColor = .white
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func addFixtureAction () {
        
        let vc = AddFixtureVC.loadFromNib()
//        vc.vm.teamFixture = self.teamFixture
        vc.teamFixture = teamFixture
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SubFixturesVC: SubFixturesDelegate {
    
    func reloadAPI() {
        guard let fixtureID = self.fixtureID else {
            return
        }
        self.fixtureVM.getTeamSubFixtureList(fixtureID: fixtureID)
    }
    
    func modelUpdated() {
        
        DispatchQueue.main.async {
            ActivityHUD().dismissProgressHUD()
            self.listTableView.reloadData()
            
            if (self.fixtureVM.teamSubFixtureResponse?.sub_fixture_creation_permission ?? 0) == 1 {
                self.setAddBtn()
            } else {
                self.navigationItem.rightBarButtonItem = nil
            }
        }
    }
}

// MARK: SubFixtureCellDelegate
extension SubFixturesVC: SubFixtureCellDelegate {
    func leftUserChatTapped(for cell: SubFixtureCell) {
        if let index = self.listTableView.indexPath(for: cell)?.row {
            self.fixtureVM.openWhatsappForHomeUser(at: index)
        }
    }
    
    func rightUserChatTapped(for cell: SubFixtureCell) {
        if let index = self.listTableView.indexPath(for: cell)?.row {
            self.fixtureVM.openWhatsappForAwayUser(at: index)
        }
    }
    
    func updateFixture(for cell: SubFixtureCell, homeScore: String?, awayScore: String?) {
         
        debugPrint(#function)
        
        guard let homeScore = homeScore else {
            showUpdateWith(msg: "Home Score is empty")
            return
        }
        
        guard let homeScore = Int(homeScore) else {
            showUpdateWith(msg: "Home Score should be a valid number")
            return
        }
        
        guard let awayScore = awayScore else {
            showUpdateWith(msg: "Aome Score is empty")
            return
        }
        
        guard let awayScore = Int(awayScore) else {
            showUpdateWith(msg: "Aome Score should be a valid number")
            return
        }
        
        guard let indexPath = listTableView.indexPath(for: cell) else {
            return
        }
        
        fixtureVM.addSubFixtureScoreAPI(for: indexPath.row, homeUserGoal: homeScore, awayUserGoal: awayScore)
        
    }
    
    func deleteFixture(for index: Int) {
        
        showConfirmationAlert(title: "Delete", message: "Are you sure you want to delete this fixture?") {
            self.fixtureVM.deleteFixtureAtIndex(index: index)
        } no: {
            
        }
    }

    
}

extension SubFixturesVC: AddFixtureVCDelegate {
    
    func updateFixtureList() {
        guard let fixtureID = self.fixtureID else {
            return
        }
        self.fixtureVM.getTeamSubFixtureList(fixtureID: fixtureID)
    }
}
