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
    
    init() {
        persistenceController = PersistenceController()
        movieRepository = MovieRepository(context: persistenceController.container.viewContext)
        getTopRatedMoviesUseCase = GetTopRatedMoviesUseCase(movieRepository: movieRepository)
    }
}
