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
    @IBOutlet weak var bgView: UIView!
    
    let setShadow = SetShadow()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setShadow.SetViewRadius(view: bgView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
