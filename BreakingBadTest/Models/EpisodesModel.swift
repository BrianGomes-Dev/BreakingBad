//
//  EpisodesModel.swift
//  TheBreakingBad
//
//  Created by 100 on 11.03.2021.
//

import Foundation
struct EpisodesModel : Codable {
    var episode_id: Int?
       var season,title: String?
       var  episode: String?
       var air_date: String?
       var characters: [String]?

       enum CodingKeys: String, CodingKey {
           case episode_id
           case title, season
           case episode
           case air_date
           case characters
       }
}

