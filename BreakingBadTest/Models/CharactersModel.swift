//
//  CharactersModel.swift
//  TheBreakingBad
//
//  Created by 100 on 11.03.2021.
//

import Foundation

struct CharactersModel : Codable {
  
    
    
    
        var charID: Int?
        var name, birthday: String?
        var occupation: [String]?
        var img: String?
        var status: String?
        var appearance: [Int]?
        var nickname, portrayed: String?

        enum CodingKeys: String, CodingKey {
            case charID
            case name, birthday, occupation, img, status, appearance, nickname, portrayed
        }
    }
