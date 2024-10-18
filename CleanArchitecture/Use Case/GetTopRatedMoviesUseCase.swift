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
    
    func load(useCached: Bool) async throws -> [Movie] {
        var cachedMovies: [Movie] = []
        if useCached {
            cachedMovies = try movieRepository.fetchTopRatedMoviesFromCoreData()
        }
        if cachedMovies.isEmpty {
            let movies = try await movieRepository.fetchTopRatedMovies()
            return movies
        }
        return cachedMovies
    }
}
