//
//  MovieDetailsScreen.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 04.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailsView: View {
    @StateObject var viewModel: MoviesViewModel
    
    let movie: Movie
    
    var body: some View {
        GeometryReader { geo in
            // MARK: - Portrait mode
            if geo.size.height > geo.size.width {
                ScrollView {
                    VStack (spacing: 16) {
                        moviePoster(aspectRatio: 3/2)
                        releaseDate()
                        HStack {
                            Spacer()
                            movieRating()
                            Spacer()
                            favoriteButton()
                            Spacer()
                        }
                        movieOverview()
                    }
                }
            }
            // MARK: - Landscape mode
            else {
                HStack {
                    moviePoster(aspectRatio: 3/4)
                    
                    ScrollView {
                        HStack {
                            Spacer()
                            movieRating()
                            Spacer()
                            favoriteButton()
                            Spacer()
                        }
                        releaseDate()
                        movieOverview()
                    }
                }
            }
        }
        .navigationTitle(movie.title)
    }
    
    func moviePoster(aspectRatio: Double) -> some View {
        WebImage(url: createImageUrl(path: movie.posterPath)) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
    }
    
    func releaseDate() -> some View {
        HStack {
            Text("Release date:")
            
            Spacer()
            
            Text(movie.releaseDate)
        }
        .padding(.horizontal, 64)
        .font(.callout)
    }
    
    func movieRating() -> some View {
        StarRatingView(rating: movie.voteAverage)
            .frame(height: 20)
    }
    
    func movieOverview() -> some View {
        Text(movie.overview)
            .font(.body)
            .multilineTextAlignment(.leading)
            .padding(.horizontal)
    }
    
    func favoriteButton() -> some View {
        Button {
            viewModel.toggleFavorite(movie: movie)
        } label: {
            Image(systemName: viewModel.isFavorite(movieID: movie.id) ? "bookmark.fill" : "bookmark")
        }
        .foregroundStyle(.primary)
    }
}

#Preview {
    let movie = Movie(
        id: 1,
        title: "Titanic",
        overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
        releaseDate: "1994-09-23",
        voteAverage: 2.0
    )
    let moviesViewModel = MockMoviesViewModel()
    
    return MovieDetailsView(
        viewModel: moviesViewModel,
        movie: movie
    )
}
