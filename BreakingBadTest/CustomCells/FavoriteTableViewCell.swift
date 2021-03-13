//
//  FavoriteTableViewCell.swift
//  BreakingBadTest
//
//  Created by 100 on 13.03.2021.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favHeartButton: UIButton!
    @IBOutlet weak var favQuoteLabel: UILabel!
    @IBOutlet weak var favAuthorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
