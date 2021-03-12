//
//  CharacterViewModel.swift
//  TheBreakingBad
//
//  Created by 100 on 11.03.2021.
//

import Foundation
import RxSwift
final class CharacterViewModel {
    let title = "Characters"
    private let modelservice : ModelServiceProtocol
    
    init(modelservice : ModelServiceProtocol = ModelService()) {
        self.modelservice = modelservice
    }
    
    func fetchCharacterviewModel() -> Observable<[CharacterListViewModel]> {
        modelservice.fetchCharacters().map { $0.map {CharacterListViewModel(character: $0)}
            
        }
    }
}
