//
//  SettingsRepository.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 18.10.2024.
//

import Foundation

protocol SettingsRepositoryProtocol {
    func topRatedMoviesRefreshSettingsValue() -> Bool
    func onTheAirMoviesRefreshSettingsValue() -> Bool
    func saveTopRatedMoviesRefreshSettingsValue(_ value: Bool)
    func saveOnTheAirMoviesRefreshSettingsValue(_ value: Bool)
}

class SettingsRepository: SettingsRepositoryProtocol {
    private let userDefaults: UserDefaults
    
    init() {
        self.userDefaults = UserDefaults.standard
    }
    
    func topRatedMoviesRefreshSettingsValue() -> Bool {
        userDefaults.bool(forKey: UserDefaultsKeys.topRatedMoviesRefreshSettings)
    }
    
    func onTheAirMoviesRefreshSettingsValue() -> Bool {
        userDefaults.bool(forKey: UserDefaultsKeys.onTheAirMoviesRefreshSettings)
    }
    
    func saveTopRatedMoviesRefreshSettingsValue(_ value: Bool) {
        userDefaults.setValue(value, forKey: UserDefaultsKeys.topRatedMoviesRefreshSettings)
    }
    
    func saveOnTheAirMoviesRefreshSettingsValue(_ value: Bool) {
        userDefaults.setValue(value, forKey: UserDefaultsKeys.onTheAirMoviesRefreshSettings)
    }
}
