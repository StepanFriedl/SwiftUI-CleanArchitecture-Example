//
//  CleanArchitectureApp.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import SwiftUI

@main
struct CleanArchitectureApp: App {
    @StateObject private var viewModel: MoviesViewModel
    
    init() {
        let movieRepository: MovieRepository = MovieRepository()
        let getTopRatedMoviesUseCase = GetTopRatedMoviesUseCase(movieRepository: movieRepository)
        _viewModel = StateObject(wrappedValue: MoviesViewModel(getTopRatedMoviesUseCase: getTopRatedMoviesUseCase))
    }
    


    var body: some Scene {
        WindowGroup {
            TabView {
                MoviesView(viewModel: viewModel)
                    .tabItem {
                        Label("Movies", systemImage: "film")
                    }
                
                FavoritesView(viewModel: viewModel)
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
            }
        }
    }
}
