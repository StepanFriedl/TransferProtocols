//
//  MainScreen.swift
//  Transfer Protocols
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

struct MainScreen: View {
    @ObservedObject private var mainVM = MainViewModel.shared
    
    var body: some View {
        ZStack {
            // MARK: - Main screen’s content
            switch mainVM.mainViewScreen {
            case .shops:
                ShopsScreen()
            case .addShop:
                AddNewShopScreen()
            case .protocols:
                ZStack {
                    switch mainVM.shopScreensPage {
                    case .allProtocols:
                        AllProtocolsView()
                    case .addNewProtocol:
                        AddNewProtocolView()
                    case .settings:
                        SettingsView()
                    case .protocolDetails:
                        ProtocolDetailsScreen()
                            .transition(.move(edge: .trailing))
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
                .background(
                    Image("backgroundVector")
                        .resizable()
                        .rotationEffect(.degrees(270))
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.5)
                        .ignoresSafeArea()
                )
            }
            
            // MARK: - Signature view
            if mainVM.showSignatureView {
                mainVM.signView
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
