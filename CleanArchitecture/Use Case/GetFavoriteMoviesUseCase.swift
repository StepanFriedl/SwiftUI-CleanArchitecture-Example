//
//  GetFavoriteMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 14.10.2024.
//

import Foundation

protocol GetFavoriteMoviesUseCaseProtocol {
    func execute() throws -> [Movie]
}

class GetFavoriteMoviesUseCase: GetFavoriteMoviesUseCaseProtocol {
    private let repository: FavoritesRepositoryProtocol
    
    init(repository: FavoritesRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws -> [Movie] {
        try repository.fetchFavoriteMovies()
    }
}
