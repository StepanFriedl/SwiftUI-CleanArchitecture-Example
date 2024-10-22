//
//  MoviesView.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var viewModel: MoviesViewModel
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            HStack {
                Picker("Ranking type", selection: $viewModel.rankingType) {
                    ForEach(RankingType.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.leading, 16)
                
                Button {
                    settingsViewModel.showSettingsSheet = true
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundStyle(.primary)
                        .frame(width: 32)
                }
            }
            
            ZStack {
                switch viewModel.rankingType {
                case .topRated:
                    if viewModel.isTopRatedLoading {
                        ProgressView("Loading...")
                    } else if let errorMessage = viewModel.topRatedErrorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    } else {
                        MovieListView(
                            moviesViewModel: viewModel,
                            movies: viewModel.topRatedMovies,
                            refreshAction: viewModel.refreshTopRatedMovies
                        )
                    }
                case .onTheAir:
                    if viewModel.isOnTheAirLoading {
                        ProgressView("Loading...")
                    } else if let errorMessage = viewModel.onTheAirErrorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    } else {
                        MovieListView(
                            moviesViewModel: viewModel,
                            movies: viewModel.onTheAirMovies,
                            refreshAction: viewModel.refreshOnTheAirMovies,
                            loadMoreAction: {
                                Task {
                                    await self.viewModel.loadNextOnTheAirMoviesPage()
                                }
                            }
                        )
                    }
                }
            }
            .frame(maxHeight: .infinity)
        }
    }
}
