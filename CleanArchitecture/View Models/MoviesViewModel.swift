//
//  MoviesViewModel.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import SwiftUI

@MainActor
class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var favoriteMovies: Set<Int> = []
    @Published var errorMessage: String?

    private let getTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol
    private let refreshTopRatedMoviesUseCase: RefreshTopRatedMoviesUseCaseProtocol
    private let favoritesKey = "favoriteMovies"
    
    init(
        getTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol,
        refreshTopRatedMoviesUseCase: RefreshTopRatedMoviesUseCaseProtocol
    ) {
        self.getTopRatedMoviesUseCase = getTopRatedMoviesUseCase
        self.refreshTopRatedMoviesUseCase = refreshTopRatedMoviesUseCase
        loadFavorites()
    }
    
    func refreshMovies() async {
        do {
            let refreshedMovies = try await refreshTopRatedMoviesUseCase.refresh()
            movies = refreshedMovies
        } catch {
            errorMessage = "Failed to refresh movies"
        }
    }
    
    func loadMovies(refresh: Bool) async {
        isLoading = true
        do {
            movies = try await getTopRatedMoviesUseCase.execute(refresh: refresh)
        } catch {
            errorMessage = "Failed to load movies"
        }
        isLoading = false
    }
    
    func toggleFavorite(movie: Movie) {
        if favoriteMovies.contains(movie.id) {
            favoriteMovies.remove(movie.id)
        } else {
            favoriteMovies.insert(movie.id)
        }
        saveFavorites()
    }
    
    func isFavorite(movie: Movie) -> Bool {
        return favoriteMovies.contains(movie.id)
    }
    
    private func saveFavorites() {
        let favoriteIDs = Array(favoriteMovies)
        UserDefaults.standard.set(favoriteIDs, forKey: favoritesKey)
    }

    private func loadFavorites() {
        if let savedFavoriteIDs = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] {
            favoriteMovies = Set(savedFavoriteIDs)
        }
    }
}
