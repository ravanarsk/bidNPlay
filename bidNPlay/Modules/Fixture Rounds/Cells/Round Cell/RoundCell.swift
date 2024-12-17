//
//  RoundCell.swift
//  bidNPlay
//
//  Created by Ashin Asok on 17/12/24.
//

import UIKit

class RoundCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var holderStack: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var arrowView: UIView!
    @IBOutlet weak var arrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: Configure Cell
extension RoundCell{
    
    fileprivate func configureCell(){
        
        self.backgroundColor = CustomColor.bg2
        self.holderView.backgroundColor = CustomColor.bg
        self.holderView.layer.cornerRadius = 10
        self.titleLabel.textColor = CustomColor.text
        self.titleLabel.font = UIFont().mediumFontWith(size: 16)
        
        self.visualEffectView.layer.cornerRadius = 10
        self.visualEffectView.layer.masksToBounds = true
        self.visualEffectView.clipsToBounds = true
        
        self.arrowImage.tintColor = CustomColor.text
        self.arrowImage.image = UIImage(
            systemName: "arrow.right.square"
        )
        
    }
    
}

//MARK: Setup Cell
extension RoundCell{
    
    internal func setRoundCell(round: Round){
        
        self.titleLabel.text = round.roundName.capitalized
        self.visualEffectView.isHidden = false
        self.arrowView.isHidden = false
        
    }
    
}
