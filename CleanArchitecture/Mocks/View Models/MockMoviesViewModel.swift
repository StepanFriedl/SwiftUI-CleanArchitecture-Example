//
//  MockMoviesViewModel.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 15.10.2024.
//

import SwiftUI

@MainActor
class MockMoviesViewModel: MoviesViewModel { 
    init() {
        super.init(
            getTopRatedMoviesUseCase: MockGetTopRatedMoviesUseCase(),
            getOnTheAirMoviesUseCase: MockGetOnTheAirMoviesUseCase(),
            refreshTopRatedMoviesUseCase: MockRefreshTopRatedMoviesUseCase(),
            toggleFavoriteMovieUseCase: MockToggleFavoriteMovieUseCase(),
            getFavoriteMoviesUseCase: MockGetFavoriteMoviesUseCase(),
            onTheAirRefreshSettingsUseCase: MockOnTheAirRefreshSettingsUseCase(),
            topRatedMoviesRefreshSettingsUseCase: MockTopRatedRefreshSettingsUseCase()
        )

        self.topRatedMovies = [
            Movie(
                id: 1,
                title: "Awesome Movie",
                overview: "Lorem ipsum dolor sit amet...",
                posterPath: nil,
                releaseDate: "2005-08-21",
                voteAverage: 4.8
            )
        ]
        self.onTheAirMovies = [
            Movie(
                id: 1,
                title: "Awesome Movie",
                overview: "Lorem ipsum dolor sit amet...",
                posterPath: nil,
                releaseDate: "2005-08-21",
                voteAverage: 4.8
            )
        ]
        self.isTopRatedLoading = false
        self.isOnTheAirLoading = false
    }
}
