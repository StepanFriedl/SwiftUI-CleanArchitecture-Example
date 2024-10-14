//
//  RefreshOnTheAirMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 14.10.2024.
//

import Foundation

class RefreshOnTheAirMoviesUseCase: RefreshOnTheAirMoviesUseCaseProtocol {
    private let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func refresh() async throws -> [Movie] {
        let refreshedMovies = try await movieRepository.fetchOnTheAirMovies()
        return refreshedMovies
    }
}
