//
//  QuoteTableViewCell.swift
//  TheBreakingBad
//
//  Created by 100 on 11.03.2021.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
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
