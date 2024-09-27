//
//  CleanArchitectureApp.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import SwiftUI

@main
struct CleanArchitectureApp: App {
    let movieRepository: MovieRepository
    let getTopRatedMoviesUseCase: GetTopRatedMoviesUseCase

    init() {
        self.movieRepository = MovieRepository()
        self.getTopRatedMoviesUseCase = GetTopRatedMoviesUseCase(movieRepository: movieRepository)
    }

    var body: some Scene {
        WindowGroup {
            MoviesView(viewModel: MoviesViewModel(getTopRatedMoviesUseCase: getTopRatedMoviesUseCase))
        }
    }
}
