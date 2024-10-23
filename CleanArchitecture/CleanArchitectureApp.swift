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
    @StateObject private var settingsViewModel: SettingsViewModel
    
    init() {
        let diContainer = DIContainer()
        self.diContainer = diContainer
        _viewModel = StateObject(wrappedValue: MoviesViewModel(
            getTopRatedMoviesUseCase: diContainer.getTopRatedMoviesUseCase,
            getOnTheAirMoviesUseCase: diContainer.getOnTheAirMoviesUseCase,
            refreshTopRatedMoviesUseCase: diContainer.refreshTopRatedMoviesUseCase,
            toggleFavoriteMovieUseCase: diContainer.toggleFavoriteMovieUseCase,
            getFavoriteMoviesUseCase: diContainer.getFavoriteMoviesUseCase,
            onTheAirRefreshSettingsUseCase: diContainer.onTheAirRefreshSettingsUseCase,
            topRatedMoviesRefreshSettingsUseCase: diContainer.topRatedMoviesRefreshSettingsUseCase,
            sortMoviesUseCase: diContainer.sortMoviesUseCase,
            filterMoviesUseCase: diContainer.filterMoviesUseCase
        ))
        _settingsViewModel = StateObject(wrappedValue: diContainer.settingsViewModel)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TabView {
                    MoviesView(
                        viewModel: viewModel,
                        settingsViewModel: settingsViewModel
                    )
                    .tabItem {
                        Label("Movies", systemImage: "film")
                    }
                    
                    FavoritesView(viewModel: viewModel)
                        .tabItem {
                            Label("Favorites", systemImage: "star.fill")
                        }
                }
            }
            .sheet(isPresented: $settingsViewModel.showSettingsSheet) {
                SettingsView(settingsViewModel: settingsViewModel)
            }
        }
    }
}
