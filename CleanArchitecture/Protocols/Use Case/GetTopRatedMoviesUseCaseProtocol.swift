//
//  GetTopRatedMoviesUseCaseProtocol.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import Foundation

protocol GetTopRatedMoviesUseCaseProtocol {
    func execute(refresh: Bool) async throws -> [Movie]
}
