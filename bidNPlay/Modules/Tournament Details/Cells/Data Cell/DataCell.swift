//
//  DataCell.swift
//  bidNPlay
//
//  Created by Ashin Asok on 05/12/24.
//

import UIKit

class DataCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: Configure cell
extension DataCell{
    
    fileprivate func configureCell(){
        
        self.holderView.layer.cornerRadius = 10
        self.titleLabel.textColor = CustomColor.text
        self.titleLabel.font = UIFont().mediumFontWith(size: 16)
        self.descLabel.textColor = CustomColor.text2
        self.descLabel.font = UIFont().mediumFontWith(size: 14)
        
    }
    
}

//MARK: Setup cell
extension DataCell{
    
    internal func setUpCell(model: TournamentDetailModel, index: Int){
        
        if index == 0{
            self.titleLabel.text = "Tournament Name"
            self.descLabel.text = model.tournament_details.tournament_title ?? ""
        }else if index == 1{
            self.titleLabel.text = "Description"
            self.descLabel.text = model.tournament_details.tournament_description ?? ""
        }else if index == 2{
            self.titleLabel.text = "Tournament Type"
            self.descLabel.text = model.tournament_details.tournament_type ?? ""
        }else if index == 3{
            self.titleLabel.text = "Tournament Code"
            self.descLabel.text = model.tournament_details.tournament_code ?? ""
        }else if index == 4{
            self.titleLabel.text = "Fixture Type"
            self.descLabel.text = model.tournament_details.fixture_type ?? ""
        }else{
            self.titleLabel.text = "Contact Admin"
            self.descLabel.text = (model.admin_country_code ?? "") + (model.admin_phone ?? "")
        }
        
    }
    
}
