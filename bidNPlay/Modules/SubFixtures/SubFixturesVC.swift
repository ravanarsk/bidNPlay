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
            let cell = tableView.dequeueReusableCell(withIdentifier: "FixtureCell", for: indexPath) as! FixtureCell
            
            let model = self.fixtureVM.getSubFixtureModel(index: indexPath.row)
            cell.setTeamSubFixtureCell(model: model)
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

extension SubFixturesVC {
    fileprivate func configureCell(){
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
        self.navigationItem.title = "Sub Fixture"
        self.fixtureVM.delegate = self
        
        
        guard let fixtureID = self.fixtureID else {
            return
        }
        self.fixtureVM.getTeamSubFixtureList(fixtureID: fixtureID)
        
    }
}

extension SubFixturesVC: SubFixturesDelegate {
    
    func modelUpdated() {
        DispatchQueue.main.async {
            ActivityHUD().dismissProgressHUD()
            self.listTableView.reloadData()
        }
    }
}
