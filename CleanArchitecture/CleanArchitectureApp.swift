//
//  CleanArchitectureApp.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import SwiftUI

@main
struct CleanArchitectureApp: App {
    private var diContainer: DIContainer
    @StateObject private var viewModel: MoviesViewModel

    init() {
        let diContainer = DIContainer()
        self.diContainer = diContainer
        _viewModel = StateObject(wrappedValue: MoviesViewModel(
            getTopRatedMoviesUseCase: diContainer.getTopRatedMoviesUseCase,
            getOnTheAirMoviesUseCase: diContainer.getOnTheAirMoviesUseCase,
            refreshTopRatedMoviesUseCase: diContainer.refreshTopRatedMoviesUseCase,
            toggleFavoriteMovieUseCase: diContainer.toggleFavoriteMovieUseCase,
            getFavoriteMoviesUseCase: diContainer.getFavoriteMoviesUseCase
        ))
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TabView {
                    MoviesView(viewModel: viewModel)
                        .tabItem {
                            Label("Movies", systemImage: "film")
                        }
                    
                    FavoritesView(viewModel: viewModel)
                        .tabItem {
                            Label("Favorites", systemImage: "star.fill")
                        }
                }
            }
        }
    }
}
