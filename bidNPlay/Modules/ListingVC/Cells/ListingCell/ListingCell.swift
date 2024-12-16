//
//  ListingCell.swift
//  bidNPlay
//
//  Created by Ashin Asok on 16/12/24.
//

import UIKit

class ListingCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var holderStack: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: Configure Cell
extension ListingCell{
    
    fileprivate func configureCell(){
        
        self.holderView.backgroundColor = CustomColor.bg2
        self.holderView.layer.cornerRadius = 10
        self.titleLabel.textColor = CustomColor.text
        self.titleLabel.font = UIFont().mediumFontWith(size: 16)
        self.subTitleLabel.textColor = CustomColor.text2
        self.subTitleLabel.font = UIFont().regularFontWith(size: 14)
        
    }
    
}

//MARK: Setup Cell
extension ListingCell{
    
    internal func setPlayerCell(player: Player){
        
        self.titleLabel.text = player.playerName?.capitalized
        self.subTitleLabel.text = "+" + player.playerCountryCode + " " + player.playerPhone
        
    }
    
    internal func setTeamCell(team: Team){
        
        self.titleLabel.text = team.teamName.capitalized
        self.subTitleLabel.text = team.captainUserName ?? ""
        
    }
    
    internal func setTeamPlayerCell(player: TeamPlayer){
        
        self.titleLabel.text = player.playerName?.capitalized
        self.subTitleLabel.text = "+" + player.playerCountryCode + " " + player.playerPhone
        
    }
    
}
