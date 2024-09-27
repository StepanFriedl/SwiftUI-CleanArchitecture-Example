//
//  MovieRepository.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import Foundation

class MovieRepository: MovieRepositoryProtocol {
    private let apiKey = "5fa2d8f6f4c8c4682dde1e813d9b1155"
    
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
