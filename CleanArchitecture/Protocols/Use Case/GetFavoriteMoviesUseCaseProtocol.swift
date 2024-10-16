//
//  GetFavoriteMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 15.10.2024.
//

import Foundation

protocol GetFavoriteMoviesUseCaseProtocol {
    func execute() throws -> [Movie]
}
