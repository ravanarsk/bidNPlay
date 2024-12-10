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
    
    internal func setUpCell(model: TournamentDetailModel){
        
        self.titleLabel.text = "Description"
        self.descLabel.text = model.tournament_details.tournament_description ?? ""
        
    }
    
}
