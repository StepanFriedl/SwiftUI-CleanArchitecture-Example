//
//  MockOnTheAirRefreshSettingsUseCase.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 21.10.2024.
//

import Foundation

class MockOnTheAirRefreshSettingsUseCase: OnTheAirRefreshSettingsUseCaseProtocol {
    func saveSettings(isOn: Bool) {
    }
    
    func getSettings() -> Bool {
        true
    }
}
