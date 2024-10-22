//
//  ToggleFavoriteMovieUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 14.10.2024.
//

import Foundation

protocol ToggleFavoriteMovieUseCaseProtocol {
    func toggleFavorite(movieID: Int, deleteOnly: Bool)
}

class ToggleFavoriteMovieUseCase: ToggleFavoriteMovieUseCaseProtocol {
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func toggleFavorite(movieID: Int, deleteOnly: Bool = false) {
        if repository.getFavoriteMovieIDs().contains(movieID) || deleteOnly {
            repository.removeFavoriteMovieID(movieID)
        } else {
            repository.saveFavoriteMovieID(movieID)
        }
    }
}
