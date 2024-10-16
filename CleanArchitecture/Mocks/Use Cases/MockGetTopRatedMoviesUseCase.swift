//
//  MockOnTheAirMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 15.10.2024.
//

import Foundation

class MockGetTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol {
    func execute(refresh: Bool) async throws -> [Movie] {
        return [
            Movie(
                id: 1,
                title: "Awesome Movie",
                overview: "Sample Overview",
                posterPath: nil,
                releaseDate: "2005-08-21",
                voteAverage: 4.8
            )
        ]
    }
}
