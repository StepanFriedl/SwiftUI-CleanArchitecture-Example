//
//  GetFavoriteMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 14.10.2024.
//

import Foundation

class GetFavoriteMoviesUseCase: GetFavoriteMoviesUseCaseProtocol {
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws -> [Movie] {
        let favoriteIDs = repository.getFavoriteMovieIDs()
        let topRatedMovies = try repository.fetchTopRatedMoviesFromCoreData()
        let onTheAirMovies = try repository.fetchOnTheAirMoviesFromCoreData()
        let allMovies = topRatedMovies + onTheAirMovies
        let uniqueMovies = Dictionary(grouping: allMovies, by: { $0.id }).compactMap { $0.value.first }
        return uniqueMovies.filter { favoriteIDs.contains($0.id) }
    }
}
