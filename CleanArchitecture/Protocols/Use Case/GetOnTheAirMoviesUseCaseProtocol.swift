//
//  GetOnTheAirMoviesUseCaseProtocol.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 09.10.2024.
//

import Foundation


protocol GetOnTheAirMoviesUseCaseProtocol {
    func execute(refresh: Bool) async throws -> [Movie]
}
