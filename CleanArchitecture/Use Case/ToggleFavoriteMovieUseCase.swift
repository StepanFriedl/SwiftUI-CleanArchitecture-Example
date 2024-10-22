//
//  ToggleFavoriteMovieUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 14.10.2024.
//

import Foundation

protocol ToggleFavoriteMovieUseCaseProtocol {
    func toggleFavorite(movie: Movie, deleteOnly: Bool)
}

class ToggleFavoriteMovieUseCase: ToggleFavoriteMovieUseCaseProtocol {
    private let repository: FavoritesRepositoryProtocol
    
    init(repository: FavoritesRepositoryProtocol) {
        self.repository = repository
    }
    
    func toggleFavorite(movie: Movie, deleteOnly: Bool = false) {
        let movieID = movie.id
        do {
            if try repository.isFavoriteMovie(movieID) || deleteOnly {
                try repository.removeFavoriteMovie(movieID)
            } else {
                try repository.saveFavoriteMovie(movie)
            }
        } catch {
            
        }
    }
}
