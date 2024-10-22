//
//  SettingsViewModel.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 21.10.2024.
//

import Foundation

class SettingsViewModel: ObservableObject {
    private let onTheAirRefreshSettingsUseCase: OnTheAirRefreshSettingsUseCaseProtocol
    private let topRatedMoviesRefreshSettingsUseCase: TopRatedMoviesRefreshSettingsUseCaseProtocol
    @Published var showSettingsSheet: Bool = false
    @Published var isOnTheAirRefreshOn: Bool = false
    @Published var isTopRatedRefreshOn: Bool = false
    
    init(
        onTheAirRefreshSettingsUseCase: OnTheAirRefreshSettingsUseCaseProtocol,
        topRatedMoviesRefreshSettingsUseCase: TopRatedMoviesRefreshSettingsUseCaseProtocol
    ) {
        self.onTheAirRefreshSettingsUseCase = onTheAirRefreshSettingsUseCase
        self.topRatedMoviesRefreshSettingsUseCase = topRatedMoviesRefreshSettingsUseCase
        loadOnTheAirRefreshSettings()
        loadTopRatedMoviesRefreshSettings()
    }
    
    private func loadOnTheAirRefreshSettings() {
        isOnTheAirRefreshOn = onTheAirRefreshSettingsUseCase.getSettings()
    }
    
    private func loadTopRatedMoviesRefreshSettings() {
        isTopRatedRefreshOn = topRatedMoviesRefreshSettingsUseCase.getSettings()
    }
    
    func toggleOnTheAirRefreshSettings() {
        isOnTheAirRefreshOn.toggle()
        onTheAirRefreshSettingsUseCase.saveSettings(isOn: isOnTheAirRefreshOn)
    }
    
    func toggleTopRatedMoviesRefreshSettings() {
        isTopRatedRefreshOn.toggle()
        topRatedMoviesRefreshSettingsUseCase.saveSettings(isOn: isTopRatedRefreshOn)
    }
}
