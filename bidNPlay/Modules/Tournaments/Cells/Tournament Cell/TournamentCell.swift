//
//  TournamentCell.swift
//  bidNPlay
//
//  Created by SectorQube Tech Mini on 04/12/24.
//

import UIKit

class TournamentCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var matchTitle: UILabel!
    @IBOutlet weak var matchCode: UILabel!
    @IBOutlet weak var ownerTitle: UILabel!
    @IBOutlet weak var winnerTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: Init View
extension TournamentCell{
    
    fileprivate func configureCell(){
        
        self.holderView.backgroundColor = CustomColor.bg2
        self.holderView.layer.cornerRadius = 10
        self.matchTitle.textColor = CustomColor.text
        self.matchCode.textColor = CustomColor.text2
        self.ownerTitle.textColor = CustomColor.text3
        self.winnerTitle.textColor = CustomColor.text4
        self.ownerTitle.text = "Owner"
        
    }
    
}

//MARK: Setup cell
extension TournamentCell{
    
    internal func setupCell(index: Int){
        
        
        if index == 0{
            self.ownerTitle.isHidden = false
            self.winnerTitle.text = "Winner: Undeclared"
        }else if index == 1{
            self.ownerTitle.isHidden = true
            self.winnerTitle.text = "Winner: Geomi"
        }else{
            self.ownerTitle.isHidden = true
            self.winnerTitle.text = "Winner: Undeclared"
        }
        
    }
    
}
