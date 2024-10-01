//
//  MoviesView.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import SwiftUI

struct MoviesView: View {
    @StateObject var viewModel: MoviesViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage).foregroundColor(.red)
            } else {
                ScrollView {
                    VStack (spacing: 0) {
                        ForEach(viewModel.movies, id: \.id) { movie in
                            Button {
                                viewModel.toggleFavorite(movie: movie)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(movie.title)
                                        .font(.headline)
                                    Text(movie.releaseDate)
                                        .font(.subheadline)
                                    Text(movie.overview)
                                        .font(.body)
                                        .lineLimit(3)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                            }
                            .background(viewModel.isFavorite(movie: movie) ? .green : .clear)
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadMovies()
            }
        }
    }
}
