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
    let getTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol
    let refreshTopRatedMoviesUseCase: RefreshTopRatedMoviesUseCaseProtocol
    let getOnTheAirMoviesUseCase: GetOnTheAirMoviesUseCaseProtocol
    let toggleFavoriteMovieUseCase: ToggleFavoriteMovieUseCaseProtocol
    let getFavoriteMoviesUseCase: GetFavoriteMoviesUseCaseProtocol
    
    init() {
        persistenceController = PersistenceController()
        movieRepository = MovieRepository(context: persistenceController.container.viewContext)
        getTopRatedMoviesUseCase = GetTopRatedMoviesUseCase(movieRepository: movieRepository)
        refreshTopRatedMoviesUseCase = RefreshTopRatedMoviesUseCase(movieRepository: movieRepository)
        getOnTheAirMoviesUseCase = GetOnTheAirMoviesUseCase(movieRepository: movieRepository)
        toggleFavoriteMovieUseCase = ToggleFavoriteMovieUseCase(repository: movieRepository)
        getFavoriteMoviesUseCase = GetFavoriteMoviesUseCase(repository: movieRepository)
    }
}
