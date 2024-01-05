//
//  BottomMenu.swift
//  Transfer Protocols
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

struct BottomMenu: View {
    @Binding var currentScreen: MainScreensTab
    
    var body: some View {
        HStack (alignment: .bottom) {
            Spacer()
            
            // MARK: - All protocols button
            Button {
                currentScreen = .allProtocols
            } label: {
                VStack {
                    Image(systemName: "list.dash")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                    
                    Spacer()
                    
                    Text("All")
                        .font(.custom(FontsManager.Quicksand.regular, size: 12))
                }
                .frame(width: 60, height: 50)
                .multilineTextAlignment(.center)
            }
//            .menuButtonColor(currentScreen == .allProtocols)
            
            Spacer()
            
            // MARK: - Add new protocol button
            Button {
                currentScreen = .addNewProtocol
            } label: {
                VStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                    
                    Spacer()
                    
                    Text("Add")
                        .font(.custom(FontsManager.Quicksand.regular, size: 12))
                }
                .frame(width: 60, height: 50)
                .multilineTextAlignment(.center)
            }
//            .menuButtonColor(currentScreen == .addNewProtocol)
            
            Spacer()
            
            // MARK: - Settings button
            Button {
                currentScreen = .settings
            } label: {
                VStack {
                    Image(systemName: "gear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                    
                    Spacer()
                    
                    Text("Settings")
                        .font(.custom(FontsManager.Quicksand.regular, size: 12))
                }
                .frame(width: 60, height: 50)
                .multilineTextAlignment(.center)
            }
//            .menuButtonColor(currentScreen == .settings)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70, alignment: .bottom)
        .background(.ultraThinMaterial)
    }
}

struct BottomMenu_Previews: PreviewProvider {
    @State static var currentScreen: MainScreensTab = .addNewProtocol
    
    static var previews: some View {
        VStack {
            Spacer()
            
            
            BottomMenu(
                currentScreen: $currentScreen
            )
        }
    }
}
