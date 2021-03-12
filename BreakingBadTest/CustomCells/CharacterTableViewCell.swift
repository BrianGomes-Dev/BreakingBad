//
//  CharacterTableViewCell.swift
//  TheBreakingBad
//
//  Created by 100 on 11.03.2021.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterpotrayLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
