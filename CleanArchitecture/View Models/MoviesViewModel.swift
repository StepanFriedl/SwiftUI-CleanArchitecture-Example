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
    @Published var errorMessage: String?

    private let getTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol
    
    init(getTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol) {
        self.getTopRatedMoviesUseCase = getTopRatedMoviesUseCase
    }
    
    func loadMovies() async {
        isLoading = true
        do {
            movies = try await getTopRatedMoviesUseCase.execute()
        } catch {
            errorMessage = "Failed to load movies"
        }
        isLoading = false
    }
}
