//
//  MockSortMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 23.10.2024.
//

import Foundation

struct MockSortMoviesUseCase: SortMoviesUseCaseProtocol {
    func sortMovies(movies: [Movie], sortBy: SortOption) -> [Movie] {
        []
    }
}
