//
//  MockGetOnTheAirMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 15.10.2024.
//

import Foundation

class MockGetOnTheAirMoviesUseCase: GetOnTheAirMoviesUseCaseProtocol {
    func load(useCached: Bool) async throws -> [Movie] {
        return []
    }
    
    func loadNextPage() async throws -> [Movie] {
        return []
    }
}
