//
//  SubFixtureCell.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 12/05/25.
//

import UIKit

protocol SubFixtureCellDelegate {
    func updateFixture(for cell: SubFixtureCell,homeScore: String?,awayScore: String?)
    func leftUserChatTapped(for cell: SubFixtureCell)
    func rightUserChatTapped(for cell: SubFixtureCell)
}

class SubFixtureCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
//    @IBOutlet weak var vsLabel: UILabel!
//    @IBOutlet weak var leftStack: UIStackView!
    @IBOutlet weak var leftTeamName: UILabel!
    @IBOutlet weak var leftScore: UILabel!
//    @IBOutlet weak var rightStack: UIStackView!
    @IBOutlet weak var rightTeamName: UILabel!
    @IBOutlet weak var rightScore: UILabel!
    
    @IBOutlet var txtLeftScore: UITextField!
    @IBOutlet var txtRightScore: UITextField!
    
    @IBOutlet var stackTxtFields: UIStackView!
    @IBOutlet var btnSubmit: UIButton!

    
    var delegate: SubFixtureCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func configureCell() {
        self.holderView.backgroundColor = CustomColor.bg2
        self.holderView.layer.cornerRadius = 10
    }
    
    internal func setTeamSubFixtureCell(model: TeamSubFixtureModel){
        self.leftTeamName.text = model.homeUserName.capitalized
        self.rightTeamName.text = model.awayUserName.capitalized
        self.leftScore.text = "\(model.homeUserGoals ?? 0)"
        self.rightScore.text = "\(model.awayUserGoals ?? 0)"
    }
    
    internal func enableUpdate(_ enable: Bool) {
        stackTxtFields.isHidden = !enable
        btnSubmit.isHidden = !enable
    }
}

extension SubFixtureCell {
    
    @IBAction func updateAction(_ sender: UIButton) {
        self.delegate?.updateFixture(for: self, homeScore: txtLeftScore.text, awayScore: txtRightScore.text)
    }
    
    @IBAction func leftUserChatAction(_ sender: UIButton) {
        self.delegate?.leftUserChatTapped(for: self)
    }
    @IBAction func rightUserChatAction(_ sender: UIButton) {
        self.delegate?.rightUserChatTapped(for: self)
    }
    
}
