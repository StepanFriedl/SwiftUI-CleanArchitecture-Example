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
            Picker("Ranking type", selection: $viewModel.rankingType) {
                ForEach(RankingType.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            ZStack {
                switch viewModel.rankingType {
                case .topRated:
                    if viewModel.isTopRatedLoading {
                        ProgressView("Loading...")
                    } else if let errorMessage = viewModel.topRatedErrorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    } else {
                        MovieListView(movies: viewModel.topRatedMovies, refreshAction: viewModel.refreshTopRatedMovies)
                    }
                case .onTheAir:
                    if viewModel.isOnTheAirLoading {
                        ProgressView("Loading...")
                    } else if let errorMessage = viewModel.onTheAirErrorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    } else {
                        MovieListView(movies: viewModel.onTheAirMovies, refreshAction: viewModel.refreshOnTheAirMovies)
                    }
                }
            }
            .frame(maxHeight: .infinity)
        }
    }
}
