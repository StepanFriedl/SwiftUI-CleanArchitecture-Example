//
//  MockSettingsViewModel.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 21.10.2024.
//

import Foundation

class MockSettingsViewModel: SettingsViewModel {
    init() {
        super.init(
            onTheAirRefreshSettingsUseCase: MockOnTheAirRefreshSettingsUseCase(),
            topRatedMoviesRefreshSettingsUseCase: MockTopRatedRefreshSettingsUseCase()
        )
    }
}

