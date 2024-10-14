//
//  RefreshOnTheAirMoviesUseCaseProtocol.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 14.10.2024.
//

import Foundation

protocol RefreshOnTheAirMoviesUseCaseProtocol {
    func refresh() async throws -> [Movie]
}
