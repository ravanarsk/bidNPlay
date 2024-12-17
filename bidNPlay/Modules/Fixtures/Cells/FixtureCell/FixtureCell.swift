//
//  FixtureCell.swift
//  bidNPlay
//
//  Created by Ashin Asok on 17/12/24.
//

import UIKit

class FixtureCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var leftStack: UIStackView!
    @IBOutlet weak var leftTeamName: UILabel!
    @IBOutlet weak var leftScore: UILabel!
    @IBOutlet weak var rightStack: UIStackView!
    @IBOutlet weak var rightTeamName: UILabel!
    @IBOutlet weak var rightScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: Configure Cell
extension FixtureCell{
    
    fileprivate func configureCell(){
        
        self.holderView.backgroundColor = CustomColor.bg2
        self.holderView.layer.cornerRadius = 10
        self.rightTeamName.textColor = CustomColor.text
        self.rightTeamName.font = UIFont().mediumFontWith(size: 16)
        self.rightScore.textColor = CustomColor.text2
        self.rightScore.font = UIFont().regularFontWith(size: 14)
        self.leftTeamName.textColor = CustomColor.text
        self.leftTeamName.font = UIFont().mediumFontWith(size: 16)
        self.leftScore.textColor = CustomColor.text2
        self.leftScore.font = UIFont().regularFontWith(size: 14)
        
    }
    
}
