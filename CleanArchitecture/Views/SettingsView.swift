//
//  SettingsView.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 21.10.2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    @State var toggleState: Bool = false
    
    var body: some View {
        VStack (spacing: 16) {
            // MARK: - Title
            Text("Settings")
                .font(.title)
            
            Divider()
            
            // MARK: - Top rated movies refresh settings
            Toggle(isOn: Binding(get: {
                settingsViewModel.isTopRatedRefreshOn
            }, set: { _ in
                settingsViewModel.toggleTopRatedMoviesRefreshSettings()
            })) {
                Text("Refresh top rated movies with every app’s launch:")
                    .multilineTextAlignment(.leading)
            }
            
            Divider()
            
            // MARK: - On  the air movies refresh settings
            Toggle(isOn: Binding(get: {
                settingsViewModel.isOnTheAirRefreshOn
            }, set: { _ in
                settingsViewModel.toggleOnTheAirRefreshSettings()
            })) {
                Text("Refresh on the air movies with every app’s launch:")
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
        .padding(32)
    }
}

#Preview {
    let settingsViewModel = MockSettingsViewModel()
    
    return SettingsView(settingsViewModel: settingsViewModel)
}
