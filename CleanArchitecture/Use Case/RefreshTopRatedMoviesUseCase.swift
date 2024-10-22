//
//  RefreshTopRatedMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 04.10.2024.
//

import Foundation

protocol RefreshTopRatedMoviesUseCaseProtocol {
    func refresh() async throws -> [Movie]
}

class RefreshTopRatedMoviesUseCase: RefreshTopRatedMoviesUseCaseProtocol {
    private let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func refresh() async throws -> [Movie] {
        let refreshedMovies = try await movieRepository.fetchTopRatedMovies()
        return refreshedMovies
    }
}
