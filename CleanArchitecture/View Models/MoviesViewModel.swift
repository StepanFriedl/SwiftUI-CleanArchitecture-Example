//
//  MoviesViewModel.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import SwiftUI

enum RankingType: String, CaseIterable {
    case topRated = "Top Rated"
    case onTheAir = "On the Air"
}

@MainActor
class MoviesViewModel: ObservableObject {
    @Published var topRatedMovies: [Movie] = []
    @Published var onTheAirMovies: [Movie] =  []
    @Published var isTopRatedLoading = false
    @Published var isOnTheAirLoading = false
    @Published var favoriteMovies: Set<Int> = []
    @Published var topRatedErrorMessage: String?
    @Published var onTheAirErrorMessage: String?
    @Published var rankingType: RankingType = .topRated

    private let getTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol
    private let refreshTopRatedMoviesUseCase: RefreshTopRatedMoviesUseCaseProtocol
    private let getOnTheAirMoviesUseCase: GetOnTheAirMoviesUseCaseProtocol
    private let refreshOnTheAirMoviesUseCase: RefreshOnTheAirMoviesUseCaseProtocol
    
    private let favoritesKey = "favoriteMovies"
    
    init(
        getTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol,
        getOnTheAirMoviesUseCase: GetOnTheAirMoviesUseCaseProtocol,
        refreshTopRatedMoviesUseCase: RefreshTopRatedMoviesUseCaseProtocol,
        refreshOnTheAirMoviesUseCase: RefreshOnTheAirMoviesUseCaseProtocol
    ) {
        self.getTopRatedMoviesUseCase = getTopRatedMoviesUseCase
        self.refreshTopRatedMoviesUseCase = refreshTopRatedMoviesUseCase
        self.getOnTheAirMoviesUseCase = getOnTheAirMoviesUseCase
        self.refreshOnTheAirMoviesUseCase = refreshOnTheAirMoviesUseCase
        loadFavorites()
    }
    
    func refreshTopRatedMovies() async {
        do {
            let refreshedMovies = try await refreshTopRatedMoviesUseCase.refresh()
            topRatedMovies = refreshedMovies
        } catch {
            topRatedErrorMessage = "Failed to refresh movies"
        }
    }
    
    func refreshOnTheAirMovies() async {
        do {
            let refreshedMovies = try await refreshOnTheAirMoviesUseCase.refresh()
            topRatedMovies = refreshedMovies
        } catch {
            onTheAirErrorMessage = "Failed to refresh movies"
        }
    }
    
    func loadOnTheAirMovies(refresh: Bool) async {
        DispatchQueue.main.async {
            self.isOnTheAirLoading = true
        }
        do {
            onTheAirMovies = try await getOnTheAirMoviesUseCase.execute(refresh: refresh)
        } catch {
            onTheAirErrorMessage = "Failed to load movies"
        }
        DispatchQueue.main.async {
            self.isOnTheAirLoading = false
        }
    }
    
    func loadTopRatedMovies(refresh: Bool) async {
        DispatchQueue.main.async {
            self.isTopRatedLoading = true
        }
        do {
            topRatedMovies = try await getTopRatedMoviesUseCase.execute(refresh: refresh)
        } catch {
            topRatedErrorMessage = "Failed to load movies"
        }
        DispatchQueue.main.async {
            self.isTopRatedLoading = false
        }
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
