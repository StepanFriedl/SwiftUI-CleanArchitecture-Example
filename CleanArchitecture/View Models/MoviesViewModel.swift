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
    @Published var favoriteMoviesList: [Movie] = []
    @Published var isTopRatedLoading = false
    @Published var isOnTheAirLoading = false
    @Published var topRatedErrorMessage: String?
    @Published var onTheAirErrorMessage: String?
    @Published var rankingType: RankingType = .topRated

    private let getTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol
    private let refreshTopRatedMoviesUseCase: RefreshTopRatedMoviesUseCaseProtocol
    private let getOnTheAirMoviesUseCase: GetOnTheAirMoviesUseCaseProtocol
    private let refreshOnTheAirMoviesUseCase: RefreshOnTheAirMoviesUseCaseProtocol
    private let toggleFavoriteMovieUseCase: ToggleFavoriteMovieUseCaseProtocol
    private let getFavoriteMoviesUseCase: GetFavoriteMoviesUseCaseProtocol
    
    init(
        getTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol,
        getOnTheAirMoviesUseCase: GetOnTheAirMoviesUseCaseProtocol,
        refreshTopRatedMoviesUseCase: RefreshTopRatedMoviesUseCaseProtocol,
        refreshOnTheAirMoviesUseCase: RefreshOnTheAirMoviesUseCaseProtocol,
        toggleFavoriteMovieUseCase: ToggleFavoriteMovieUseCaseProtocol,
        getFavoriteMoviesUseCase: GetFavoriteMoviesUseCaseProtocol
    ) {
        self.getTopRatedMoviesUseCase = getTopRatedMoviesUseCase
        self.refreshTopRatedMoviesUseCase = refreshTopRatedMoviesUseCase
        self.getOnTheAirMoviesUseCase = getOnTheAirMoviesUseCase
        self.refreshOnTheAirMoviesUseCase = refreshOnTheAirMoviesUseCase
        self.toggleFavoriteMovieUseCase = toggleFavoriteMovieUseCase
        self.getFavoriteMoviesUseCase = getFavoriteMoviesUseCase
        self.loadFavoriteMovies()
        Task {
            await self.loadTopRatedMovies(refresh: true)
            await self.loadOnTheAirMovies(refresh: true)
            // TODO: - Add settings for this later
        }
    }
    
    func loadFavoriteMovies() {
        do {
            favoriteMoviesList = try getFavoriteMoviesUseCase.execute()
        } catch {
            print("Loading favorite movies failed")
            // TODO: - Add error handling
        }
    }
    
    func toggleFavorite(forID movieID: Int, deleteOnly: Bool = false) {
        toggleFavoriteMovieUseCase.toggleFavorite(movieID: movieID, deleteOnly: deleteOnly)
        loadFavoriteMovies()
    }
    
    func isFavorite(movieID: Int) -> Bool {
        return favoriteMoviesList.contains(where: { $0.id == movieID })
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
}
