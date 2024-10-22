//
//  DIContainer.swift.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 03.10.2024.
//

import Foundation

class DIContainer {
    let persistenceController: PersistenceController
    let movieRepository: MovieRepositoryProtocol
    let favoritesRepository: FavoritesRepositoryProtocol
    let getTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol
    let refreshTopRatedMoviesUseCase: RefreshTopRatedMoviesUseCaseProtocol
    let getOnTheAirMoviesUseCase: GetOnTheAirMoviesUseCaseProtocol
    let toggleFavoriteMovieUseCase: ToggleFavoriteMovieUseCaseProtocol
    let getFavoriteMoviesUseCase: GetFavoriteMoviesUseCaseProtocol
    
    let onTheAirRefreshSettingsUseCase: OnTheAirRefreshSettingsUseCaseProtocol
    let topRatedMoviesRefreshSettingsUseCase: TopRatedMoviesRefreshSettingsUseCaseProtocol
    let settingsViewModel: SettingsViewModel
    
    init() {
        persistenceController = PersistenceController()
        movieRepository = MovieRepository(context: persistenceController.container.viewContext)
        favoritesRepository = FavoritesRepository(context: persistenceController.container.viewContext)
        getTopRatedMoviesUseCase = GetTopRatedMoviesUseCase(movieRepository: movieRepository)
        refreshTopRatedMoviesUseCase = RefreshTopRatedMoviesUseCase(movieRepository: movieRepository)
        getOnTheAirMoviesUseCase = GetOnTheAirMoviesUseCase(movieRepository: movieRepository)
        toggleFavoriteMovieUseCase = ToggleFavoriteMovieUseCase(repository: favoritesRepository)
        getFavoriteMoviesUseCase = GetFavoriteMoviesUseCase(repository: favoritesRepository)
        let settingsRepository = SettingsRepository()
        onTheAirRefreshSettingsUseCase = OnTheAirRefreshSettingsUseCase(settingsRepository: settingsRepository)
        topRatedMoviesRefreshSettingsUseCase = TopRatedMoviesRefreshSettingsUseCase(settingsRepository: settingsRepository)
        settingsViewModel = SettingsViewModel(
            onTheAirRefreshSettingsUseCase: onTheAirRefreshSettingsUseCase,
            topRatedMoviesRefreshSettingsUseCase: topRatedMoviesRefreshSettingsUseCase
        )
    }
}
