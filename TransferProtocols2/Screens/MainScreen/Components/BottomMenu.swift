//
//  BottomMenu.swift
//  Transfer Protocols
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

struct BottomMenu: View {
    @ObservedObject private var mainVM = MainViewModel.shared
    
    var body: some View {
        HStack (alignment: .bottom) {
            Spacer()
            
            // MARK: - All protocols button
            Button {
                mainVM.shopScreensPage = .allProtocols
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
                .frame(width: 60, height: 45)
                .multilineTextAlignment(.center)
            }
            .menuButtonColor(mainVM.shopScreensPage == .allProtocols)
            
            Spacer()
            
            // MARK: - Add new protocol button
            Button {
                mainVM.shopScreensPage = .addNewProtocol
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
                .frame(width: 60, height: 45)
                .multilineTextAlignment(.center)
            }
            .menuButtonColor(mainVM.shopScreensPage == .addNewProtocol)
            
            Spacer()
            
            // MARK: - Settings button
            Button {
                mainVM.shopScreensPage = .settings
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
                .frame(width: 60, height: 45)
                .multilineTextAlignment(.center)
            }
            .menuButtonColor(mainVM.shopScreensPage == .settings)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70, alignment: .bottom)
        .padding(.bottom, 15)
        .background(.ultraThinMaterial)
    }
}

struct BottomMenu_Previews: PreviewProvider {
    @State static var currentScreen: ShopScreensPage = .addNewProtocol
    
    static var previews: some View {
        VStack {
            Spacer()
            
            BottomMenu()
        }
    }
}
