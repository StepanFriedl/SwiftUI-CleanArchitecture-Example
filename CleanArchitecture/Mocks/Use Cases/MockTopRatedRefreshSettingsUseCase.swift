//
//  MockTopRatedRefreshSettingsUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 21.10.2024.
//

import Foundation

class MockTopRatedRefreshSettingsUseCase: TopRatedMoviesRefreshSettingsUseCaseProtocol {
    func saveSettings(isOn: Bool) {
    }
    
    func getSettings() -> Bool {
        true
    }
}
