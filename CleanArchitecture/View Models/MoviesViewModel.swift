//
//  MoviesViewModel.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import SwiftUI

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
    private let toggleFavoriteMovieUseCase: ToggleFavoriteMovieUseCaseProtocol
    private let getFavoriteMoviesUseCase: GetFavoriteMoviesUseCaseProtocol
    private let sortMoviesUseCase: SortMoviesUseCaseProtocol
    private let filterMoviesUseCase: FilterMoviesUseCaseProtocol
    
    init(
        getTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol,
        getOnTheAirMoviesUseCase: GetOnTheAirMoviesUseCaseProtocol,
        refreshTopRatedMoviesUseCase: RefreshTopRatedMoviesUseCaseProtocol,
        toggleFavoriteMovieUseCase: ToggleFavoriteMovieUseCaseProtocol,
        getFavoriteMoviesUseCase: GetFavoriteMoviesUseCaseProtocol,
        onTheAirRefreshSettingsUseCase: OnTheAirRefreshSettingsUseCaseProtocol,
        topRatedMoviesRefreshSettingsUseCase: TopRatedMoviesRefreshSettingsUseCaseProtocol,
        sortMoviesUseCase: SortMoviesUseCaseProtocol,
        filterMoviesUseCase: FilterMoviesUseCaseProtocol
    ) {
        self.getTopRatedMoviesUseCase = getTopRatedMoviesUseCase
        self.refreshTopRatedMoviesUseCase = refreshTopRatedMoviesUseCase
        self.getOnTheAirMoviesUseCase = getOnTheAirMoviesUseCase
        self.toggleFavoriteMovieUseCase = toggleFavoriteMovieUseCase
        self.getFavoriteMoviesUseCase = getFavoriteMoviesUseCase
        self.sortMoviesUseCase = sortMoviesUseCase
        self.filterMoviesUseCase = filterMoviesUseCase
        self.loadFavoriteMovies()
        Task {
            let onTheAirRefreshSettings = onTheAirRefreshSettingsUseCase.getSettings()
            let topRatedMoviesRefreshSettings = topRatedMoviesRefreshSettingsUseCase.getSettings()
            await self.loadTopRatedMovies(useCached: !topRatedMoviesRefreshSettings)
            await self.loadOnTheAirMovies(useCached: !onTheAirRefreshSettings)
        }
    }
    
    func loadFavoriteMovies() {
        do {
            favoriteMoviesList = try getFavoriteMoviesUseCase.execute()
        } catch {
            // TODO: - Add error handling
        }
    }
    
    func toggleFavorite(movie: Movie, deleteOnly: Bool = false) {
        toggleFavoriteMovieUseCase.toggleFavorite(movie: movie, deleteOnly: deleteOnly)
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
            onTheAirMovies = try await getOnTheAirMoviesUseCase.load(useCached: false)
        } catch {

        }
    }
    
    func loadOnTheAirMovies(useCached: Bool) async {
        DispatchQueue.main.async {
            self.isOnTheAirLoading = true
        }
        do {
            onTheAirMovies = try await getOnTheAirMoviesUseCase.load(useCached: useCached)
        } catch {
            onTheAirErrorMessage = "Failed to load movies"
        }
        DispatchQueue.main.async {
            self.isOnTheAirLoading = false
        }
    }
    
    func loadNextOnTheAirMoviesPage() async {
        do {
            onTheAirMovies.append(contentsOf: try await getOnTheAirMoviesUseCase.loadNextPage())
        } catch {
            
        }
    }
    
    func loadTopRatedMovies(useCached: Bool) async {
        DispatchQueue.main.async {
            self.isTopRatedLoading = true
        }
        do {
            topRatedMovies = try await getTopRatedMoviesUseCase.load(useCached: useCached)
        } catch {
            topRatedErrorMessage = "Failed to load movies"
        }
        DispatchQueue.main.async {
            self.isTopRatedLoading = false
        }
    }
    
    func sortMovies(movies: [Movie], sortBy: SortOption) -> [Movie] {
        sortMoviesUseCase.sortMovies(movies: movies, sortBy: sortBy)
    }
    
    func filterMovies(movies: [Movie], query: String) -> [Movie] {
        filterMoviesUseCase.filterMovies(movies: movies, query: query)
    }
}
