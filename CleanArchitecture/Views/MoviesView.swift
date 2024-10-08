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
                List(viewModel.movies, id: \.id) { movie in
                    NavigationLink(destination: MovieDetailsView(movie: movie)) {
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                            Text(movie.releaseDate)
                                .font(.subheadline)
                            Text(movie.overview)
                                .font(.body)
                                .lineLimit(3)
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .refreshable {
                    Task {
                        await viewModel.refreshMovies()
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
            }
        }
    }
}
