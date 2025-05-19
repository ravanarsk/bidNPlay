//
//  AddFixtureVC.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 12/05/25.
//

import UIKit

protocol AddFixtureVCDelegate {
    func updateFixtureList()
}


class AddFixtureVC: BaseVC {
    
    @IBOutlet var btnHomePlayer: UIButton!
    @IBOutlet var btnAwayPlayer: UIButton!
    
    var delegate: AddFixtureVCDelegate? 
    
    
    internal var teamFixture: TeamFixture? {
        didSet {
            vm.teamFixture = teamFixture
        }
    }
    
    private var vm = AddFixtureVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setBackButton()
        
        vm.delegate = self
        vm.getTeamPlayers()
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

// MARK: AddFixtureDelegate
extension AddFixtureVC: AddFixtureDelegate {
    func apiComplete() {
        DispatchQueue.main.async {
            ActivityHUD().dismissProgressHUD()
        }
    }
    
    func subFixtureAdded() {
        self.delegate?.updateFixtureList()
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: IBAction UIButton
extension AddFixtureVC {
    @IBAction func selectHomePlayerAction (_ sender: UIButton) {
        let vc = PickerVC.loadFromNib()
        if let players =  vm.homePlayersResponse?.players {
            vc.arrayItems = players
        }
        vc.delegate = self
        vc.identifier = 1
        present(vc, animated: true)
    }
    
    @IBAction func selectAwayPlayerAction (_ sender: UIButton) {
        let vc = PickerVC.loadFromNib()
        if let players =  vm.awayPlayersResponse?.players {
            vc.arrayItems = players
        }
        vc.delegate = self
        vc.identifier = 2
        present(vc, animated: true)
    }
    
    @IBAction func addFixtureAction (_ sender: UIButton) {
        if validate() {
            vm.addTeamPlayerFixture()
        }
    }
    
    private func validate() -> Bool {
        if vm.selectedHomePlayer == nil {
            showUpdateWith(msg: "Please select a home player")
            return false
        } else if vm.selectedAwayPlayer == nil {
            showUpdateWith(msg: "Please select a away player")
            return false
        } else {
            return true
        }
    }
}
 
extension AddFixtureVC: PickerVCDelegate {
    func view(_ view: PickerVC, didSelect item: Int) {
        if view.identifier == 1, let item = vm.homePlayersResponse?.players[item] { // Home Team player selection
            vm.selectedHomePlayer = item
            btnHomePlayer.setTitle(item.displayText(), for: .normal)
            btnHomePlayer.setTitle(item.displayText(), for: .selected)
        } else if view.identifier == 2, let item = vm.awayPlayersResponse?.players[item] { // Away Team player selection
            vm.selectedAwayPlayer = item
            btnAwayPlayer.setTitle(item.displayText(), for: .normal)
            btnAwayPlayer.setTitle(item.displayText(), for: .selected)
        }
        
        view.dismiss(animated: true)
    }
    
}


