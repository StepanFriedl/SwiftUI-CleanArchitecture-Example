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
    
    func execute() async throws -> [Movie] {
        return try await movieRepository.fetchTopRatedMovies()
    }
}
