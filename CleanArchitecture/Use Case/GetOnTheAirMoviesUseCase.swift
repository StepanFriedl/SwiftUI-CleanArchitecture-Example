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
    
    func execute(refresh: Bool) async throws -> [Movie] {
        let cachedMovies = try movieRepository.fetchOnTheAirMoviesFromCoreData()
        if cachedMovies.isEmpty {
            let movies = try await movieRepository.fetchOnTheAirMovies()
            return movies
        } else {
            if refresh {
                do {
                    let movies = try await movieRepository.fetchOnTheAirMovies()
                    return movies
                } catch {
                    print("Error fetching on the air movies from API: \(error.localizedDescription)")
                }
            }
        }
        return cachedMovies
    }
}
