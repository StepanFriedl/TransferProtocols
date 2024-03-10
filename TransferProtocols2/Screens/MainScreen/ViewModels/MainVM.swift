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
    case protocolDetails
    case handOutProtocol
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
    @Published var showSignatureView: Bool = false
    
    // MARK: - Data
    @Published var presentedProtocol: String = "" {
        didSet {
            withAnimation(.easeInOut(duration: 0.3)) {
                profileDetailsScreenShown = true
            }
        }
    }
    @Published var selectedShop: Shop? = nil
    @Published var selectedProtocol: TransferProtocol? = nil
    @Published var signView = SignatureView(closeViewAction: { _ in })
    var signatureData: Data = Data()
    var signatureViewAction: (UIImage) -> Void = { _ in }
    
    func isProtocolsItemReturned(transferProtocol: TransferProtocol?) -> Bool {
        return transferProtocol?.handingOutPlace?.count ?? 0 > 0
    }
}
