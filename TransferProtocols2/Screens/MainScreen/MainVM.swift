//
//  MainVM.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

class MainViewModel: ObservableObject {
    static let shared = MainViewModel()
    
    // MARK: - Views controls
    @Published var mainScreensPage: MainScreensTab = .addNewProtocol
    @Published var profileDetailsScreenShown: Bool = false
    
    // MARK: - Data
    @Published var presentedProtocol: String = "" {
        didSet {
            withAnimation(.easeInOut(duration: 0.3)) {
                profileDetailsScreenShown = true
            }
        }
    }
}
