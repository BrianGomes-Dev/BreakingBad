//
//  DesignKit.swift
//  BreakingBadTest
//
//  Created by Brian Gomes on 14/03/2021.
//

import Foundation
import UIKit

class SetShadow{
    
    func SetViewRadius(view:UIView){
        view.layer.cornerRadius = 18.0
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = 14.0
        view.layer.shadowOpacity = 0.6
    }
}


