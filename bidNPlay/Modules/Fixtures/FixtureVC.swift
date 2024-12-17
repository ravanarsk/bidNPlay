//
//  FixtureVC.swift
//  bidNPlay
//
//  Created by Ashin Asok on 16/12/24.
//

import UIKit

class FixtureVC: BaseVC {

    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var changeRoundButton: UIButton!
    
    fileprivate let fixtureVM = FixtureVM()
    
    internal var roundNo : Int?
    internal var roundName : String?
    internal var tournamentID : Int?
    internal var isIndividual : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupCell()
    }

}

//MARK: Configure view
extension FixtureVC{
    
    fileprivate func configureCell(){
        
        self.changeRoundButton.setDefaultTheme(name: "Change Round")
        self.roundLabel.textColor = CustomColor.text
        self.roundLabel.font = UIFont().semiBoldFontWith(size: 18)
        self.listTableView.backgroundColor = CustomColor.bg
        self.listTableView.registerCells(names: [
            "FixtureCell","EmptyListCell"
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
        self.navigationItem.title = "Fixture"
        self.roundLabel.text = "Round Name: \((self.roundName ?? "").capitalized)"
        self.fixtureVM.delegate = self
        self.fixtureVM.isIndividual = self.isIndividual
        self.callFixtureAPI()
        
    }
    
    fileprivate func callFixtureAPI(){
        
        guard let tournamentID = self.tournamentID, let roundNo = self.roundNo else{
            return
        }
        self.fixtureVM.getIndividualFixtureList(
            tournamentID: tournamentID,
            roundNo: roundNo
        )
        
    }
    
}

//MARK: Tableview Delegates
extension FixtureVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fixtureVM.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.fixtureVM.isEmpty() == true{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyListCell", for: indexPath) as! EmptyListCell
            cell.messageLabel.text = "List Empty"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FixtureCell", for: indexPath) as! FixtureCell
            if self.isIndividual{
                let model = self.fixtureVM.getIndividualModel(
                    index: indexPath.row
                )
                cell.setIndividualCell(model: model)
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.fixtureVM.isEmpty(){
            return self.listTableView.frame.height
        }else{
            return 120
        }
        
    }
    
}

//MARK: View model Delegates
extension FixtureVC: FixtureDelegate{
    
    func modelUpdated() {
        
        DispatchQueue.main.async {
            
            ActivityHUD().dismissProgressHUD()
            self.listTableView.reloadData()
            
        }
        
    }
    
}
