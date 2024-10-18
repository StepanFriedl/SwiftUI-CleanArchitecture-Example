//
//  GetOnTheAirMoviesUseCaseProtocol.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 09.10.2024.
//

import Foundation


protocol GetOnTheAirMoviesUseCaseProtocol {
    func load(useCached: Bool) async throws -> [Movie]
    func loadNextPage() async throws -> [Movie]
}
