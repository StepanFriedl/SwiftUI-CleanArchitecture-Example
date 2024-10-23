//
//  SortMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 23.10.2024.
//

import Foundation

protocol SortMoviesUseCaseProtocol {
    func sortMovies(movies: [Movie], sortBy: SortOption) -> [Movie]
}

struct SortMoviesUseCase: SortMoviesUseCaseProtocol {
    func sortMovies(movies: [Movie], sortBy: SortOption) -> [Movie] {
        switch sortBy {
        case .nameAsc:
            return movies.sorted { $0.title < $1.title }
        case .nameDesc:
            return movies.sorted { $0.title > $1.title }
        case .releaseYearAsc:
            return movies.sorted { Int($0.getReleaseYear()) ?? 0 < Int($1.getReleaseYear()) ?? 0 }
        case .releaseYearDesc:
            return movies.sorted { Int($0.getReleaseYear()) ?? 0 > Int($1.getReleaseYear()) ?? 0 }
        case .ratingAsc:
            return movies.sorted { $0.voteAverage < $1.voteAverage }
        case .ratingDesc:
            return movies.sorted { $0.voteAverage > $1.voteAverage }
        case .defaultOption:
            return movies.sorted { $0.id < $1.id }
        }
    }
}
