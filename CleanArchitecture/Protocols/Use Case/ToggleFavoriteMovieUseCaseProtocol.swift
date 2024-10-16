//
//  ToggleFavoriteMovieUseCaseProtocol.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 15.10.2024.
//

import Foundation

protocol ToggleFavoriteMovieUseCaseProtocol {
    func toggleFavorite(movieID: Int, deleteOnly: Bool)
}
