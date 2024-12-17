//
//  HeaderCell.swift
//  bidNPlay
//
//  Created by Ashin Asok on 09/12/24.
//

import UIKit

protocol HeaderCellDelegate{
    func leaveJoinClicked()
    func fixtureClicked()
}

class HeaderCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var dividerLine: UIView!
    @IBOutlet weak var tournamentName: UILabel!
    @IBOutlet weak var tournamentCode: UILabel!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var leaveButton: UIButton!
    @IBOutlet weak var fixtureButton: UIButton!
    
    internal var delegate : HeaderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: Configure Cell
extension HeaderCell{
    
    fileprivate func configureCell(){
        
        self.holderView.layer.cornerRadius = 10
        self.holderView.backgroundColor = CustomColor.bg2
        self.tournamentName.textColor = CustomColor.text
        self.tournamentName.font = UIFont().mediumFontWith(size: 20)
        self.tournamentCode.textColor = CustomColor.text2
        self.tournamentCode.font = UIFont().regularFontWith(size: 12)
        self.fixtureButton.setDefaultTheme(name: "Fixture")
        self.fixtureButton.addTarget(
            self, action: #selector(fixtureAction), for: .touchUpInside
        )
        self.leaveButton.addTarget(
            self, action: #selector(leaveJoinAction), for: .touchUpInside
        )
        
    }
    
}

//MARK: Set Up Cell
extension HeaderCell{
    
    internal func setUpCell(model: TournamentDetailModel){
        
        self.tournamentName.text = (model.tournament_details.tournament_title ?? "").capitalized
        self.tournamentCode.text = model.tournament_details.tournament_code ?? ""
        if let joined = model.already_joined, joined == 1{
            self.leaveButton.setDefaultTheme(name: "Leave")
        }else{
            self.leaveButton.setDefaultTheme(name: "Join")
        }
        
    }
    
}

//MARK: Button Actions
extension HeaderCell{
    
    @objc fileprivate func leaveJoinAction(){
        self.delegate?.leaveJoinClicked()
    }
    
    @objc fileprivate func fixtureAction(){
        self.delegate?.fixtureClicked()
    }
}
