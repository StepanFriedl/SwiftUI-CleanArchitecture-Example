//
//  MovieListView.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 14.10.2024.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var moviesViewModel: MoviesViewModel
    let movies: [Movie]
    let refreshAction: () async -> Void
    var deleteAction: ((_: Int) -> Void)? = nil
    
    var body: some View {
        if movies.count > 0 {
            List(movies, id: \.id) { movie in
                NavigationLink(destination: MovieDetailsView(viewModel: moviesViewModel, movie: movie)) {
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
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    if let deleteAction = deleteAction {
                        Button(role: .destructive) {
                            deleteAction(movie.id)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .refreshable {
                Task {
                    await refreshAction()
                }
            }
            .listStyle(PlainListStyle())
            .background(Color.clear)
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
}

#Preview {
    let movie = Movie(
        id: 1,
        title: "Awesome Movie",
        overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        posterPath: nil,
        releaseDate: "2005-08-21",
        voteAverage: 4.8
    )
    let moviesViewModel = MockMoviesViewModel()
    
    return MovieListView(
        moviesViewModel: moviesViewModel,
        movies: [movie],
        refreshAction: {}
    )
}
