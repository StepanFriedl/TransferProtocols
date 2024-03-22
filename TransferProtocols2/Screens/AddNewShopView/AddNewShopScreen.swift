//
//  AddNewShopView.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 19.02.2024.
//

import SwiftUI

struct AddNewShopScreen: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var shops: FetchedResults<Shop>
    
    @State private var companyName: String = ""
    @State private var registrationNumber: String = ""
    @State private var shopsLogo: UIImage? = nil
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var protocolsTitle: String = ""
    @State private var protocolDescription: String = ""
    @State private var itemSpecificationTitle1: String = ""
    @State private var itemSpecificationTitle2: String = ""
    @State private var handingInTitle1: String = ""
    @State private var handingInTitle2: String = ""
    @State private var handingOutTitle1: String = ""
    @State private var handingOutTitle2: String = ""
    
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView (showsIndicators: false) {
                VStack (spacing: 25) {
                    
                    // MARK: - Shop / Company name
                    TextField("Company name", text: $companyName)
                        .newProtocolTextInput()
                    
                    // MARK: - Registration number / date of birth / birth number
                    TextField("Registration number", text: $registrationNumber)
                        .newProtocolTextInput()
                    
                    // MARK: - Shop’s logo
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        if let shopsLogo = shopsLogo {
                            Image(uiImage: shopsLogo)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 200)
                        } else {
                            Text("ADD LOGO")
                        }
                    }
                    
                    // MARK: - Phone number
                    TextField("Phone number", text: $phoneNumber)
                        .newProtocolTextInput()
                    
                    // MARK: - Email
                    TextField("Email", text: $email)
                        .newProtocolTextInput()
                    
                    // MARK: - Protocol title
                    TextField("Protocol’s title", text: $protocolsTitle)
                        .newProtocolTextInput()
                    
                    // MARK: - Protocol description
                    TextField("Protocol’s description", text: $protocolDescription, axis: .vertical)
                        .newProtocolTextInput()
                    
                    // MARK: - Item specification row 1's title
                    TextField("Item specification 1’s title", text: $itemSpecificationTitle1)
                        .newProtocolTextInput()
                    
                    // MARK: - Item specification row 2's title
                    TextField("Item specification 2’s title", text: $itemSpecificationTitle2)
                        .newProtocolTextInput()
                    
                    // MARK: - Handing in specification row 1's title
                    TextField("Handing in specification 1’s title", text: $handingInTitle1)
                        .newProtocolTextInput()
                    
                    // MARK: - Handing in specification row 2's title
                    TextField("Handing in specification 2’s title", text: $handingInTitle2)
                        .newProtocolTextInput()
                    
                    // MARK: - Handing out specification row 1's title
                    TextField("Handing out specification 1’s title", text: $handingOutTitle1)
                        .newProtocolTextInput()
                    
                    // MARK: - Handing out specification row 2's title
                    TextField("Handing out specification 2’s title", text: $handingOutTitle2)
                        .newProtocolTextInput()
                    
                    // TODO: - Add protocols preview
                    
                    
                    // MARK: - Save button
                    Button {
                        self.saveShop()
                    } label: {
                        Text("SAVE")
                            .saveButton()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .padding(.horizontal)
                .padding(.top, 100)
                .padding(.bottom, 300)
            }
            .padding(.horizontal, 32)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("backgroundVector")
                    .resizable()
                    .rotationEffect(.degrees(270))
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.5)
                    .ignoresSafeArea()
            )
            
            // MARK: - Screen’s title
            VStack {
                ZStack {
                    VStack {
                        Spacer()
                        
                        Text("Add a new shop".uppercased())
                            .font(.custom(FontsManager.Quicksand.bold, size: 24))
                            .padding(.bottom, 16)
                    }
                    
                    // back button
                    VStack {
                        HStack {
                            Button {
                                MainViewModel.shared.mainViewScreen = .shops
                            } label: {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.gray)
                                    .padding(16)
                                    .padding(.horizontal, 16)
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 75)
                .background(.ultraThinMaterial)
                
                Spacer()
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $shopsLogo)
        }
    }
    
    private func saveShop() {
        do {
            let shop = Shop(context: moc)
            shop.id = UUID()
            shop.companyName = companyName
            shop.registrationNumber = registrationNumber
            shop.logoImage = shopsLogo?.pngData()
            shop.phoneNumber = phoneNumber
            shop.email = email
            shop.created = Date.now
            shop.transferProtocolTitle = protocolsTitle
            shop.protocolDescription = protocolDescription
            shop.itemSpecification1Title = itemSpecificationTitle1
            shop.itemSpecification2Title = itemSpecificationTitle2
            shop.handingInSpecification1Title = handingInTitle1
            shop.handingInSpecification2Title = handingInTitle2
            shop.handingOutSpecification1Title = handingOutTitle1
            shop.handingOutSpecification2Title = handingOutTitle2
            
            try moc.save()
            
            MainViewModel.shared.mainViewScreen = .shops
        } catch {
            // TODO: - Add error alert
        }
        
    }
}

#Preview {
    AddNewShopScreen()
}
