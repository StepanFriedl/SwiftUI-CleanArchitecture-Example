//
//  FilterMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 23.10.2024.
//

import Foundation

protocol FilterMoviesUseCaseProtocol {
    func filterMovies(movies: [Movie], query: String) -> [Movie]
}

struct FilterMoviesUseCase: FilterMoviesUseCaseProtocol {
    func filterMovies(movies: [Movie], query: String) -> [Movie] {
        guard !query.isEmpty else { return movies }
        return movies.filter { movie in
            movie.title.lowercased().contains(query.lowercased())
        }
    }
}
