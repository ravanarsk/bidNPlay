//
//  BasicInfoCell.swift
//  bidNPlay
//
//  Created by Ashin Asok on 09/12/24.
//

import UIKit

class BasicInfoCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var whatsappButton: UIButton!
    @IBOutlet weak var tournamentTypeLabel: UILabel!
    @IBOutlet weak var tournamentTypeValue: UILabel!
    @IBOutlet weak var fixtureTypeLabel: UILabel!
    @IBOutlet weak var fixtureTypeValue: UILabel!
    @IBOutlet weak var adminLabel: UILabel!
    @IBOutlet weak var adminValue: UILabel!
    @IBOutlet weak var cellHeaderTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: Configure cell
extension BasicInfoCell{
    
    fileprivate func configureCell(){
        
        self.holderView.layer.cornerRadius = 10
        self.holderView.backgroundColor = CustomColor.bg2
        
        self.cellHeaderTitle.text = "Additional Info"
        self.cellHeaderTitle.textColor = CustomColor.text
        self.cellHeaderTitle.font = UIFont().mediumFontWith(size: 16)
        
        self.tournamentTypeLabel.text = "Type"
        self.tournamentTypeLabel.textColor = CustomColor.text
        self.tournamentTypeLabel.font = UIFont().mediumFontWith(size: 14)
        
        self.fixtureTypeLabel.text = "Fixture Type"
        self.fixtureTypeLabel.textColor = CustomColor.text
        self.fixtureTypeLabel.font = UIFont().mediumFontWith(size: 14)
        
        self.adminLabel.text = "Admin Contact Number"
        self.adminLabel.textColor = CustomColor.text
        self.adminLabel.font = UIFont().mediumFontWith(size: 14)
        
        self.tournamentTypeValue.textColor = CustomColor.text2
        self.tournamentTypeValue.font = UIFont().regularFontWith(size: 12)
        
        self.fixtureTypeValue.textColor = CustomColor.text2
        self.fixtureTypeValue.font = UIFont().regularFontWith(size: 12)
        
        self.adminValue.textColor = CustomColor.text2
        self.adminValue.font = UIFont().regularFontWith(size: 12)
        
        self.whatsappButton.setWhatsappTheme()
        
    }
    
}

//MARK: Set up Cell
extension BasicInfoCell{
    
    internal func setUpCell(model: TournamentDetailModel){
        
        self.tournamentTypeValue.text = (model.tournament_details.tournament_type ?? "").capitalized
        self.fixtureTypeValue.text = (model.tournament_details.fixture_type ?? "").capitalized
        self.adminValue.text = (model.admin_country_code ?? "") + (model.admin_phone ?? "")
        
    }
}
