//
//  MockRefreshTopRatedMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 15.10.2024.
//

import Foundation

class MockRefreshTopRatedMoviesUseCase: RefreshTopRatedMoviesUseCaseProtocol {
    func refresh() async throws -> [Movie] {
        return []
    }
}
