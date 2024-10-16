//
//  MockGetOnTheAirMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 15.10.2024.
//

import Foundation

class MockGetOnTheAirMoviesUseCase: GetOnTheAirMoviesUseCaseProtocol {
    func execute(refresh: Bool) async throws -> [Movie] {
        return []
    }
}
