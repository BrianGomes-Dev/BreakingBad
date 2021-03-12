//
//  CharacterListViewModel.swift
//  TheBreakingBad
//
//  Created by 100 on 11.03.2021.
//

import Foundation
struct CharacterListViewModel {
    
    private let character : CharactersModel
   
    var displayName : String {
        return character.name!
    }
    
    var displayPortray : String {
        return character.portrayed!
    }
    var displayImage : String {
        return character.img!
    }
    var displayOccupation : [String] {
        return character.occupation!
    }
    var displayNickname : String {
        return character.nickname!
    }
    var displayBirthday : String {
        return character.birthday!
    }
//    func numberOfRowsInSection() -> Int {
//        return character.
//       }
    init (character : CharactersModel) {
        self.character = character
        
    }
}
