//
//  GetTopRatedMoviesUseCaseProtocol.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import Foundation

protocol GetTopRatedMoviesUseCaseProtocol {
    func load(useCached: Bool) async throws -> [Movie]
}
