//
//  FixtureRoundVC.swift
//  bidNPlay
//
//  Created by Ashin Asok on 17/12/24.
//

import UIKit

class FixtureRoundVC: BaseVC {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var closeImage: UIImageView!
    @IBOutlet weak var closeHolderView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    internal var fixtureVM = FixtureRoundVM()
    internal var tournamentID : Int?
    internal var delegate : GetRoundDetailDelegate?
    
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
extension FixtureRoundVC{
    
    fileprivate func configureView(){
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        self.holderView.layer.cornerRadius = 10
        self.holderView.backgroundColor = CustomColor.bg2
        
        self.titleLabel.textColor = CustomColor.text
        self.titleLabel.font = UIFont().mediumFontWith(size: 18)
        
        self.closeHolderView.layer.cornerRadius = self.closeHolderView.frame.height/2
        self.closeHolderView.backgroundColor = CustomColor.bg2
        
        self.closeButton.addTarget(
            self, action: #selector(closeView), for: .touchUpInside
        )
        
        self.listTableView.backgroundColor = CustomColor.bg2
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
        
        self.titleLabel.text = "Select a round"
        self.fixtureVM.delegate = self
        self.fixtureVM.getIndividualFixtureRoundList(
            tournamentID: self.tournamentID!
        )
        
    }
    
}

//MARK: Button Actions
extension FixtureRoundVC{
    
    @objc fileprivate func closeView(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

//MARK: Tableview delegates
extension FixtureRoundVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.fixtureVM.getRowCount()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.fixtureVM.isEmpty() == true{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyListCell", for: indexPath) as! EmptyListCell
            cell.messageLabel.text = "No Tournaments"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoundCell", for: indexPath) as! RoundCell
            let model = self.fixtureVM.getSelectedModelWith(index: indexPath.row)
            cell.setRoundCell(round: model)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.fixtureVM.isEmpty() == true{
            return self.listTableView.frame.height
        }else{
            return 100
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = self.fixtureVM.getSelectedModelWith(
            index: indexPath.row
        )
        self.delegate?.selectedRound(round: model)
        self.dismiss(animated: true)
        
    }
    
}

//MARK: View Model Delegates
extension FixtureRoundVC: RoundDelegate{
   
    func modelUpdated() {
        
        DispatchQueue.main.async {
            
            ActivityHUD().dismissProgressHUD()
            self.listTableView.reloadData()
            
        }
        
    }
    
}
