//
//  MockFilterMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 23.10.2024.
//

import Foundation

struct MockFilterMoviesUseCase: FilterMoviesUseCaseProtocol {
    func filterMovies(movies: [Movie], query: String) -> [Movie] {
        []
    }
}
