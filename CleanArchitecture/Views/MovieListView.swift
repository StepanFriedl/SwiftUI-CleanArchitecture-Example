//
//  MovieListView.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 14.10.2024.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var moviesViewModel: MoviesViewModel
    @State private var searchQuery: String = ""
    @State private var showSearchBar: Bool = true
    @State private var sortingOption: SortOption = .defaultOption
    let movies: [Movie]
    let refreshAction: () async -> Void
    var loadMoreAction: (() async -> Void)? = nil
    var deleteAction: ((_: Movie) -> Void)? = nil
    
    var filteredSortedMovies: [Movie] {
        moviesViewModel.filterMovies(
            movies: moviesViewModel.sortMovies(movies: movies, sortBy: sortingOption),
            query: searchQuery
        )
    }
    
    var body: some View {
        if movies.count > 0 {
            VStack {
                if (showSearchBar || !searchQuery.isEmpty) && movies.count > 0 {
                    HStack {
                        TextField("Search", text: $searchQuery)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(uiColor: .systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(.leading, 16)
                            .padding(.top, 16)
                            .scaleEffect(showSearchBar || !searchQuery.isEmpty ? 1 : 0, anchor: .top)

                        Menu {
                            ForEach(SortOption.allCases, id: \.self) { option in
                                Button {
                                    sortingOption = option
                                } label: {
                                    HStack {
                                        Text(option.rawValue)
                                        
                                        if sortingOption == option {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        } label: {
                            Button {
                                
                            } label: {
                                Image(systemName: "arrow.up.arrow.down")
                                    .foregroundStyle(.primary)
                                    .frame(width: 32)
                            }
                        }
                    }
                }
                
                List(filteredSortedMovies, id: \.id) { movie in
                    NavigationLink(destination: MovieDetailsView(viewModel: moviesViewModel, movie: movie)) {
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                            Text(movie.getReleaseYear())
                                .font(.subheadline)
                            Text(movie.overview)
                                .font(.body)
                                .lineLimit(3)
                        }
                        .onAppear {
                            if movie == filteredSortedMovies.first {
                                withAnimation {
                                    showSearchBar = true
                                }
                            }
                            if movie == filteredSortedMovies.last {
                                if let loadMoreAction = loadMoreAction {
                                    Task {
                                        await                                    loadMoreAction()
                                    }
                                }
                            }
                        }
                        .onDisappear {
                            if movie == filteredSortedMovies.first {
                                withAnimation {
                                    showSearchBar = false
                                }
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        if let deleteAction = deleteAction {
                            Button(role: .destructive) {
                                deleteAction(movie)
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
            }
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
