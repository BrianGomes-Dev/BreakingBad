//
//  EpisodeListViewModel.swift
//  TheBreakingBad
//
//  Created by 100 on 12.03.2021.
//

import Foundation
struct EpisodeListViewModel {
    
    private let episode : EpisodesModel
   
    var displayAirdate : String {
        return episode.airDate!
    }
    
    var displayCharacters : [String] {
        return episode.characters!
    }
//    var displayEpisodes : Int {
//        return episode.episode!
//    }
    var displaySeason : String {
        return episode.season!
    }
    var displayTitle : String {
        return episode.title!
    }
    var displayId : Int {
        return episode.episodeID!
    }
   
    
//    func numberOfRowsInSection() -> Int {
//        return character.
//       }
    init (episode : EpisodesModel) {
        self.episode = episode
        
    }
}
