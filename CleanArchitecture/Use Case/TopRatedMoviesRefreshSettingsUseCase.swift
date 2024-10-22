//
//  TopRatedMoviesRefreshSettingsUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 21.10.2024.
//

import Foundation

protocol TopRatedMoviesRefreshSettingsUseCaseProtocol {
    func saveSettings(isOn: Bool)
    func getSettings() -> Bool
}

class TopRatedMoviesRefreshSettingsUseCase: TopRatedMoviesRefreshSettingsUseCaseProtocol {
    private let settingsRepository: SettingsRepositoryProtocol
    
    init(settingsRepository: SettingsRepositoryProtocol) {
        self.settingsRepository = settingsRepository
    }

    func saveSettings(isOn: Bool) {
        self.settingsRepository.saveTopRatedMoviesRefreshSettingsValue(isOn)
    }
    
    func getSettings() -> Bool {
        self.settingsRepository.topRatedMoviesRefreshSettingsValue()
    }
}
