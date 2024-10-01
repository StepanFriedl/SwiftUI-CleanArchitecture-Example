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
        ScrollView {
            VStack (spacing: 0) {
                ForEach(viewModel.movies.filter { viewModel.isFavorite(movie: $0) }, id: \.id) { movie in
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
                    
                    Divider()
                }
            }
        }
    }
}


//#Preview {
//    FavoritesView()
//}
