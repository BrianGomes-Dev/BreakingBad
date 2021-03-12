//
//  EpisodeViewModel.swift
//  TheBreakingBad
//
//  Created by 100 on 11.03.2021.
//

import Foundation
import RxSwift
final class EpisodeViewModel {
    let title = "Episodes"
    private let modelservice : ModelServiceProtocol
    
    init(modelservice : ModelServiceProtocol = ModelService()) {
        self.modelservice = modelservice
    }
    
//    func fetchEpisodeviewModel() -> Observable<[EpisodeListViewModel]> {
//        modelservice.fetchEpisodes().map { $0.map {EpisodeListViewModel(episode: $0)}
//
//        }
//    }
}
