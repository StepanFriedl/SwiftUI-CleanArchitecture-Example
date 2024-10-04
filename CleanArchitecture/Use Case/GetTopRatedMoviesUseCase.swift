//
//  GetTopRatedMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import Foundation

class GetTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol {
    
    private let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func execute(refresh: Bool) async throws -> [Movie] {
        let cachedMovies = try movieRepository.fetchTopRatedMoviesFromCoreData()
        if cachedMovies.isEmpty {
            let movies = try await movieRepository.fetchTopRatedMovies()
            return movies
        } else {
            if refresh {
                do {
                    return try await movieRepository.fetchTopRatedMovies()
                } catch {
                    print("Error fetching top rated movies from API: \(error.localizedDescription)")
                }
                return cachedMovies
            }
        }
        return cachedMovies
    }
}
