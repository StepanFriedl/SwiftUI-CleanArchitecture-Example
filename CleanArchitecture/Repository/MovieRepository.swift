//
//  MovieRepository.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import Foundation

class MovieRepository: MovieRepositoryProtocol {
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    
    func fetchTopRatedMovies() async throws -> [Movie] {
        let urlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        return decodedResponse.results
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}
