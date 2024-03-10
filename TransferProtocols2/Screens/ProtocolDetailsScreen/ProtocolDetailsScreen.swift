//
//  ProtocolDetailsScreen.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

struct ProtocolDetailsScreen: View {
    @StateObject private var mainVM = MainViewModel.shared
    @FetchRequest(
        sortDescriptors: [],
        predicate: NSPredicate(format: "transferProtocol == %@", argumentArray: [MainViewModel.shared.selectedProtocol ?? TransferProtocol()])
    ) var protocolPictures: FetchedResults<HandingInPicture>

    
    var body: some View {
        ZStack {
            // MARK: - The protocol
            ScrollView (showsIndicators: false) {
                VStack (alignment: .leading) {
                    // MARK: - Company
                    Text("Company")
                        .protocolDetailsBigTitle()
                    
                    // Company logo
                    if let companyLogo = mainVM.selectedShop?.logoImage,
                       let logoUiImage = UIImage(data: companyLogo) {
                        HStack {
                            Image(uiImage: logoUiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: UIScreen.main.bounds.size.width / 3, maxHeight: 150)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    // Company name
                    Text("Name:")
                        .protocolDetailsTitle()
                    Text(mainVM.selectedShop?.companyName ?? "Unknown name")
                        .protocolDetailsText()
                    
                    // Company registration number
                    Text("Registration number:")
                        .protocolDetailsTitle()
                    Text(mainVM.selectedShop?.registrationNumber ?? "Unknown registration number")
                        .protocolDetailsText()
                    
                    // Company email
                    Text("Email:")
                        .protocolDetailsTitle()
                    ContactLink(
                        linkType: .emailAddress,
                        contactValue: mainVM.selectedShop?.email ?? "Unknown email"
                    )
                    .protocolDetailsText()
                    
                    // Company phone number
                    Text("Phone number:")
                        .protocolDetailsTitle()
                    ContactLink(
                        linkType: .phoneNumber,
                        contactValue: mainVM.selectedShop?.phoneNumber ?? "Unknown number"
                    )
                    .protocolDetailsText()
                    
                    // MARK: - Customer
                    Text("Customer")
                        .protocolDetailsBigTitle()
                    
                    VStack (alignment: .leading, spacing: 2) {
                        // Customer’s full name
                        Text("Name:")
                            .protocolDetailsTitle()
                        Text(mainVM.selectedProtocol?.customerFullName ?? "Unknown name")
                            .protocolDetailsText()
                        
                        // Customer’s birth date
                        Text("Birth date:")
                            .protocolDetailsTitle()
                        Text(mainVM.selectedProtocol?.customerBirthDate?.toString() ?? "Unknown birth date")
                            .protocolDetailsText()
                        
                        // Customer’s phone number
                        Text("Phone number:")
                            .protocolDetailsTitle()
                        ContactLink(
                            linkType: .phoneNumber,
                            contactValue: mainVM.selectedProtocol?.customerPhoneNumber ?? "Unknown phone number"
                        )
                        .protocolDetailsText()
                        
                        // Customer’s email
                        Text("Email:")
                            .protocolDetailsTitle()
                        ContactLink(
                            linkType: .emailAddress,
                            contactValue: mainVM.selectedProtocol?.customerEmail ?? "Unknown email"
                        )
                        .protocolDetailsText()
                    }
                    
                    // MARK: - Item
                    Text("Item")
                        .protocolDetailsBigTitle()
                    
                    VStack (alignment: .leading, spacing: 2) {
                        // Item specification 1
                        if mainVM.selectedProtocol?.itemSpecificationTitle1?.count ?? 0 > 0 {
                            Text(mainVM.selectedProtocol?.itemSpecificationTitle1 ?? "Unknown title")
                                .protocolDetailsTitle()
                            Text(mainVM.selectedProtocol?.itemSpecificationValue1 ?? "Unknown")
                                .protocolDetailsText()
                        }
                        
                        // Item specification 2
                        if mainVM.selectedProtocol?.itemSpecificationTitle2?.count ?? 0 > 0 {
                            Text(mainVM.selectedProtocol?.itemSpecificationTitle2 ?? "Unknown title")
                                .protocolDetailsTitle()
                            Text(mainVM.selectedProtocol?.itemSpecificationValue2 ?? "Unknown")
                                .protocolDetailsText()
                        }
                    }
                    
                    // MARK: - Photos
                    // TODO: - Add photos when ready
                    
                    // MARK: - Handing in specifications
                    Text("Handing in specification")
                        .protocolDetailsBigTitle()
                    
                    // Handing in specification 1
                    if mainVM.selectedProtocol?.handingInSpecificationTitle1?.count ?? 0 > 0 {
                        Text(mainVM.selectedProtocol?.handingInSpecificationTitle1 ?? "Unknown title")
                            .protocolDetailsTitle()
                        Text(mainVM.selectedProtocol?.handingInSpecificationValue1 ?? "Unknown")
                            .protocolDetailsText()
                    }
                    
                    // Handing in specification 2
                    if mainVM.selectedProtocol?.handingInSpecificationTitle2?.count ?? 0 > 0 {
                        Text(mainVM.selectedProtocol?.handingInSpecificationTitle2 ?? "Unknown title")
                            .protocolDetailsTitle()
                        Text(mainVM.selectedProtocol?.handingInSpecificationValue2 ?? "Unknown")
                            .protocolDetailsText()
                    }
                    
                    // Handing in place
                    Text("Place:")
                        .protocolDetailsTitle()
                    Text(mainVM.selectedProtocol?.handingInPlace ?? "Unknown place")
                        .protocolDetailsText()
                    
                    // Handing in date
                    Text("Date:")
                        .protocolDetailsTitle()
                    Text(mainVM.selectedProtocol?.handingInDate?.toString() ?? "Unknown date")
                        .protocolDetailsText()
                    
                    ScrollView (.horizontal) {
                        HStack {
                            ForEach(protocolPictures, id: \.self) { protocolPicture in
                                if let pictureData = protocolPicture.pictureData,
                                   let uiImage = UIImage(data: pictureData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 150)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                    
                    // Handing in customer signature
                    Text("Customer’s signature:")
                        .protocolDetailsTitle()
                    if let imageData = mainVM.selectedProtocol?.handingInCustomerSignature,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 150)
                    }
                    
                    // Handing in company representative name
                    Text("Company representative’s name:")
                        .protocolDetailsTitle()
                    Text(mainVM.selectedProtocol?.handingInPersonName ?? "Unknown name")
                        .protocolDetailsText()
                    
                    // Handing in company representative signature
                    Text("Company representative’s signature:")
                        .protocolDetailsTitle()
                    
                    if let imageData = mainVM.selectedProtocol?.handingInCompanyRepresentativeSignature,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 150)
                    }
                    
                    // MARK: - Handing out specifications
                    if mainVM.isProtocolsItemReturned(transferProtocol: mainVM.selectedProtocol) {
                        Text("Handing out specification")
                            .protocolDetailsBigTitle()
                        
                        // Handing out specification 1
                        if mainVM.selectedProtocol?.handingOutSpecificationTitle1?.count ?? 0 > 0 {
                            Text(mainVM.selectedProtocol?.handingOutSpecificationTitle1 ?? "Unknown title")
                                .protocolDetailsTitle()
                            Text(mainVM.selectedProtocol?.handingOutSpecificationValue1 ?? "Unknown")
                                .protocolDetailsText()
                        }
                        
                        // Handing out specification 2
                        if mainVM.selectedProtocol?.handingOutSpecificationTitle2?.count ?? 0 > 0 {
                            Text(mainVM.selectedProtocol?.handingOutSpecificationTitle2 ?? "Unknown title")
                                .protocolDetailsTitle()
                            Text(mainVM.selectedProtocol?.handingOutSpecificationValue2 ?? "Unknown")
                                .protocolDetailsText()
                        }
                        
                        // Handing out place
                        Text("Place:")
                            .protocolDetailsTitle()
                        Text(mainVM.selectedProtocol?.handingOutPlace ?? "Unknown place")
                            .protocolDetailsText()
                        
                        // Handing out date
                        Text("Date:")
                            .protocolDetailsTitle()
                        Text(mainVM.selectedProtocol?.handingOutDate?.toString() ?? "Unknown date")
                            .protocolDetailsText()
                        
                        // Handing out customer’s name
                        Text("Customer’s name:")
                            .protocolDetailsTitle()
                        Text(mainVM.selectedProtocol?.handingOutCustomerName ?? "Unknown name")
                            .protocolDetailsText()
                        
                        // Handing out customer’s signature
                        Text("Customer’s signature:")
                            .protocolDetailsTitle()
                        if let imageData = mainVM.selectedProtocol?.handingOutCustomerSignature,
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 150)
                        }
                        
                        // Handing out company representative’s signature
                        Text("Company representative’s name:")
                            .protocolDetailsTitle()
                        if let imageData = mainVM.selectedProtocol?.handingOutCompanyRepresentativeSignature,
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 150)
                        }
                    } else {
                        Text("Item hasn’t been returned yet.")
                        
                        Button {
                            mainVM.shopScreensPage = .handOutProtocol
                        } label: {
                            Text("hand out".uppercased())
                        }
                        .saveButton()
                    }
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 102)
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
