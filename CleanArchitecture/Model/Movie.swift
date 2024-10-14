//
//  Movie.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import Foundation

struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case name
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        
        if let title = try? container.decode(String.self, forKey: .title) {
            self.title = title
        } else {
            self.title = try container.decode(String.self, forKey: .name)
        }
        
        overview = try container.decode(String.self, forKey: .overview)
        posterPath = try? container.decode(String.self, forKey: .posterPath)
        
        if let releaseDate = try? container.decode(String.self, forKey: .releaseDate) {
            self.releaseDate = releaseDate
        } else {
            self.releaseDate = try container.decode(String.self, forKey: .firstAirDate)
        }
        
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
    }
    
    init(id: Int, title: String, overview: String, posterPath: String?, releaseDate: String, voteAverage: Double) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
    }
}
