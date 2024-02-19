//
//  MainVM.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

enum ShopScreensPage {
    case allProtocols
    case addNewProtocol
    case settings
}

enum MainViewsScreen {
    case shops
    case addShop
    case protocols
}

class MainViewModel: ObservableObject {
    static let shared = MainViewModel()
    
    // MARK: - Views controls
    @Published var shopScreensPage: ShopScreensPage = .addNewProtocol
    @Published var profileDetailsScreenShown: Bool = false
    @Published var mainViewScreen: MainViewsScreen = .shops
    
    // MARK: - Data
    @Published var presentedProtocol: String = "" {
        didSet {
            withAnimation(.easeInOut(duration: 0.3)) {
                profileDetailsScreenShown = true
            }
        }
    }
}
