//
//  GetOnTheAirMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 09.10.2024.
//

import Foundation

class GetOnTheAirMoviesUseCase: GetOnTheAirMoviesUseCaseProtocol {
    
    private let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func load(useCached: Bool) async throws -> [Movie] {
        // execute again to load another page
        var cachedMovies: [Movie] = []
        if useCached {
            cachedMovies = try movieRepository.fetchOnTheAirMoviesFromCoreData()
        } else {
            try movieRepository.clearOnTheAirMoviesFromCoreData()
            movieRepository.resetNextPageToLoadOnTheAirMovies()
        }
        if cachedMovies.isEmpty {
            let movies = try await movieRepository.fetchOnTheAirMovies()
            return movies
        }
        return cachedMovies
    }
    
    func loadNextPage() async throws -> [Movie] {
        try await movieRepository.fetchOnTheAirMovies()
    }
}
