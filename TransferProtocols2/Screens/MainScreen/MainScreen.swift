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
    @State private var currentScreen: MainScreensTab = .addNewProtocol
    
    var body: some View {
        ZStack {
            VStack {
                switch currentScreen {
                case .allProtocols:
                    AllProtocolsView()
                    
                case .addNewProtocol:
                    AddNewProtocolView()
                    
                case .settings:
                    VStack {
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.yellow)
                }
            }
            
            // MARK: - Bottom menu
            VStack {
                Spacer()
                
                BottomMenu(
                    currentScreen: $currentScreen
                )
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
