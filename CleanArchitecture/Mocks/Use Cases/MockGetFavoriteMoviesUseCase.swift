//
//  MockGetFavoriteMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 15.10.2024.
//

import Foundation

class MockGetFavoriteMoviesUseCase: GetFavoriteMoviesUseCaseProtocol {
    func execute() throws -> [Movie] {
        return []
    }
}
