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
//       var  episode: Int?
       var airDate: String?
       var characters: [String]?

       enum CodingKeys: String, CodingKey {
           case episode_id
           case title, season
//                case episode
           case airDate
           case characters
       }
}

