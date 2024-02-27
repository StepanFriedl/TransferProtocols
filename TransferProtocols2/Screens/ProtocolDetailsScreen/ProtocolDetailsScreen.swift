//
//  ProtocolDetailsScreen.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

struct ProtocolDetailsScreen: View {
    @StateObject private var mainVM = MainViewModel.shared
    
    var body: some View {
        ZStack {
            // MARK: - The protocol
            ScrollView (showsIndicators: false) {
                VStack (alignment: .leading) {
                    // MARK: - Company
                    HStack (alignment: .center, spacing: 16) {
                        if let companyLogo = mainVM.selectedShop?.logoImage,
                           let logoUiImage = UIImage(data: companyLogo) {
                            Image(uiImage: logoUiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: UIScreen.main.bounds.size.width / 3, maxHeight: 150)
                        }
                        
                        
                        VStack (alignment: .leading, spacing: 2) {
                            Text("Company")
                                .protocolDetailsBigTitle()
                            
                            
                            Text("Name:")
                                .protocolDetailsTitle()
                            
                            Text(mainVM.selectedShop?.companyName ?? "Unknown name")
                                .protocolDetailsText()
                            
                            Text("Registration number:")
                                .protocolDetailsTitle()
                            
                            Text(mainVM.selectedShop?.registrationNumber ?? "Unknown registration number")
                                .protocolDetailsText()
                            
                            Text("Email:")
                                .protocolDetailsTitle()
                            
                            Text(mainVM.selectedShop?.email ?? "Unknown email")
                                .protocolDetailsText()
                        }
                    }
                    
                    // MARK: - Customer
                    VStack (alignment: .leading, spacing: 2) {
                        
                    }
                    
                    // MARK: - Item
                    
                    
                    // MARK: - Photos
                    
                    
                    // MARK: - Handing in specifications
                    
                    
                    // MARK: - Handing in signature specifications
                    
                    
                    // MARK: - Handing out specifications
                    
                    
                    // MARK: - Handing out signature specifications
                    
                    
                }
                .padding(.horizontal, 32)
                .padding(.top, 102)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // MARK: - Top toolbar
            VStack {
                ZStack (alignment: .bottom) {
                    Text("Protocol details")
                        .font(.custom(FontsManager.Quicksand.semiBold, size: 18))
                    
                    HStack {
                        Button {
                            mainVM.shopScreensPage = .allProtocols
                            mainVM.selectedProtocol = nil
                        } label: {
                            Image(systemName: "chevron.left")
                                .padding(.horizontal, 16)
                        }
                        Spacer()
                    }
                }
                .foregroundStyle(.black)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(.ultraThinMaterial)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ProtocolDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolDetailsScreen()
    }
}
