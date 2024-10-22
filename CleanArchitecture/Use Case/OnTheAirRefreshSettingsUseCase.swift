//
//  OnTheAirRefreshSettingsUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 21.10.2024.
//

import Foundation

protocol OnTheAirRefreshSettingsUseCaseProtocol {
    func saveSettings(isOn: Bool)
    func getSettings() -> Bool
}

class OnTheAirRefreshSettingsUseCase: OnTheAirRefreshSettingsUseCaseProtocol {
    private let settingsRepository: SettingsRepositoryProtocol
    
    init(settingsRepository: SettingsRepositoryProtocol) {
        self.settingsRepository = settingsRepository
    }
    
    func saveSettings(isOn: Bool) {
        self.settingsRepository.saveOnTheAirMoviesRefreshSettingsValue(isOn)
    }
    
    func getSettings() -> Bool {
        self.settingsRepository.onTheAirMoviesRefreshSettingsValue()
    }
}
