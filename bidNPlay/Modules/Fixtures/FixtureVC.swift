//
//  FixtureVC.swift
//  bidNPlay
//
//  Created by Ashin Asok on 16/12/24.
//

import UIKit

class FixtureVC: UIViewController {

    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var changeRoundButton: UIButton!
    
    let fixtureVM = FixtureVM()
    
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
        
        self.listTableView.backgroundColor = CustomColor.bg
        self.listTableView.registerCells(names: [
            "FixtureCell","EmptyListCell"
        ])
        self.listTableView.tableFooterView = UIView()
        self.listTableView.separatorStyle = .none
        self.listTableView.showsVerticalScrollIndicator = false
        self.listTableView.showsHorizontalScrollIndicator = false
        //self.listTableView.delegate = self
        //self.listTableView.dataSource = self
        
    }
    
    fileprivate func setupCell(){
        
        //self.fixtureVM.delegate = self
        
    }
    
}
