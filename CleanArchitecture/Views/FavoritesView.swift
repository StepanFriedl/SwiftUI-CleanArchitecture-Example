//
//  FavoritesView.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel: MoviesViewModel

    var body: some View {
        VStack {
            if viewModel.favoriteMoviesList.count > 0 {
                MovieListView(
                    moviesViewModel: viewModel,
                    movies: viewModel.favoriteMoviesList,
                    refreshAction: viewModel.loadFavoriteMovies,
                    deleteAction: { movieID in
                        viewModel.toggleFavorite(forID: movieID, deleteOnly: true)
                    }
                )
            } else {
                VStack {
                    Text("No movies to display. Please try again later!")
                        .font(.body)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
                .padding(64)
            }
        }
        .onAppear {
            viewModel.loadFavoriteMovies()
        }
    }
}


#Preview {
    let moviesViewModel = MockMoviesViewModel()
    
    return FavoritesView(viewModel: moviesViewModel)
}
