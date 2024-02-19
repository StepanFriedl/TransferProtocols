//
//  AddNewShopView.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 19.02.2024.
//

import SwiftUI

struct AddNewShopScreen: View {
    @State private var companyName: String = ""
    @State private var registrationNumber: String = ""
    @State private var shopsLogo: UIImage? = nil
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var protocolsTitle: String = ""
    @State private var itemSpecificationTitle1: String = ""
    @State private var itemSpecificationTitle2: String = ""
    @State private var handingOverTitle1: String = ""
    @State private var handingOverTitle2: String = ""
    @State private var takingOverTitle1: String = ""
    @State private var takingOverTitle2: String = ""
    
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
                    
                    // MARK: - Item specification row 1's title
                    TextField("Item specification 1’s title", text: $itemSpecificationTitle1)
                        .newProtocolTextInput()
                    
                    // MARK: - Item specification row 2's title
                    TextField("Item specification 2’s title", text: $itemSpecificationTitle2)
                        .newProtocolTextInput()
                    
                    // MARK: - Handing over specification row 1's title
                    TextField("Handing over specification 1’s title", text: $handingOverTitle1)
                        .newProtocolTextInput()
                    
                    // MARK: - Handing over specification row 2's title
                    TextField("Handing over specification 2’s title", text: $handingOverTitle2)
                        .newProtocolTextInput()
                    
                    // MARK: - Taking over specification row 1's title
                    TextField("Taking over specification 1’s title", text: $takingOverTitle1)
                        .newProtocolTextInput()
                    
                    // MARK: - Taking over specification row 2's title
                    TextField("Taking over specification 2’s title", text: $takingOverTitle2)
                        .newProtocolTextInput()
                    
                    // TODO: - Add protocols preview
                    
                    
                    // MARK: - Save button
                    Button {
                        print("I will save the shop one day")
                    } label: {
                        Text("SAVE")
                            .saveButton()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .padding(.horizontal)
                .padding(.top, 100)
                .padding(.bottom, 64)
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
}

#Preview {
    AddNewShopScreen()
}
