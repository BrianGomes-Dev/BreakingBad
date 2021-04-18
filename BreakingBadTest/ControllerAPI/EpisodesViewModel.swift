//
//  EpisodesViewModel.swift
//  BreakingBadTest
//
//  Created by Brian Gomes on 18/04/2021.
//

import Foundation

struct EpisodeViewModel {
    
    let seasonNum:String?
    let episodeTitle:String?
    
    var episode_id: Int?
    var airDate: String?
    var characters: [String]?
    
    init(Episodes:EpisodesModel) {
        self.seasonNum = "Season : \(Episodes.season ?? "")"
        self.episodeTitle = Episodes.title
        self.episode_id = Episodes.episode_id
        self.airDate = Episodes.airDate
        self.characters = Episodes.characters
    }
    
    
}
