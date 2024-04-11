//
//  SettingsView.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject private var mainVM = MainViewModel.shared

    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (spacing: 8) {
                Button {
                    mainVM.selectedShop = nil
                    mainVM.mainViewScreen = .shops
                    mainVM.shopScreensPage = .addNewProtocol
                } label: {
                    Text("Change shop")
                        .font(.custom(FontsManager.Quicksand.bold, size: 25))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .foregroundStyle(.red)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.ultraThinMaterial)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(.gray)
                        )
                        .padding(.horizontal, 64)
                }
            }
            .padding(.bottom, 70)
            .padding(.top, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
