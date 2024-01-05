//
//  MainScreen.swift
//  Transfer Protocols
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

enum MainScreensTab {
    case allProtocols
    case addNewProtocol
    case settings
}

struct MainScreen: View {
    @ObservedObject private var mainVM = MainViewModel.shared
    
    var body: some View {
        ZStack {
            // MARK: - Main screen’s content
            switch mainVM.mainScreensPage {
            case .allProtocols:
                AllProtocolsView()
            case .addNewProtocol:
                AddNewProtocolView()
            case .settings:
                SettingsView()
            }
            
            // MARK: - Bottom menu
            VStack {
                Spacer()
                
                BottomMenu()
            }
            
            // MARK: - Protocol details screen
            if mainVM.profileDetailsScreenShown {
                ProtocolDetailsScreen()
                    .transition(.move(edge: .trailing) )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
