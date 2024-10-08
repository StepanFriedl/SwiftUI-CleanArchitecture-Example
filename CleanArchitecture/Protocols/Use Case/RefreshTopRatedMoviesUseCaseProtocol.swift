//
//  RefreshTopRatedMoviesUseCaseProtocol.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 04.10.2024.
//

import Foundation

protocol RefreshTopRatedMoviesUseCaseProtocol {
    func refresh() async throws -> [Movie]
}
