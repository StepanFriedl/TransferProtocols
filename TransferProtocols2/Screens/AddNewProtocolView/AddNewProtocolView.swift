//
//  AddNewProtocolView.swift
//  Transfer Protocols
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

struct AddNewProtocolView: View {
    @ObservedObject private var newProtocolVM = AddNewProtocolViewModel()
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (alignment: .leading, spacing: 25) {
                Group {
                    // MARK: - Full name
                    TextField("Full name", text: $newProtocolVM.newPickupProtocol.fullName)
                        .newProtocolTextInput()
                    
                    // MARK: - Phone number
                    TextField("Phone number", text: $newProtocolVM.newPickupProtocol.phoneNumber)
                        .newProtocolTextInput()
                        .keyboardType(.phonePad)
                    
                    // MARK: - Email address
                    TextField("Email address", text: $newProtocolVM.newPickupProtocol.emailAddress)
                        .newProtocolTextInput()
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }
                
                Group {
                    // MARK: - Car model
                    TextField("Car model", text: $newProtocolVM.newPickupProtocol.carModel)
                        .newProtocolTextInput()
                    
                    // MARK: - Licence plate
                    TextField("Licence plate", text: $newProtocolVM.newPickupProtocol.licencePlate)
                        .newProtocolTextInput()
                    
                    // MARK: - Visible defects
                    TextEditor(text: $newProtocolVM.newPickupProtocol.visibleDefects)
                        .background(Color.clear)
                        .newProtocolTextInput()
                    
                    // MARK: - Add photo
                    Button {
                        print("I will add the most beatiful photo one day.")
                    } label: {
                        HStack {
                            Image(systemName: "plus.square.fill")
                                .opacity(0.5)
                            Text("Add Photo")
                        }
                    }
                    .addPhotoButton()

                    // MARK: - Number of attached photos
                    Text("Attached photos: \(newProtocolVM.newPickupProtocol.photos.count)")
                        .font(.custom(FontsManager.Quicksand.regular, size: 18))
                    
                    HStack {
                        // MARK: - Pickup location
                        TextField("Pickup location", text: $newProtocolVM.newPickupProtocol.pickupLocation)
                            .newProtocolTextInput()
                        
                        // MARK: - Pickup date
                        Text(newProtocolVM.newPickupProtocol.pickupDate.formatted(.dateTime.day().month().year()))
                            .dateTextView()
                            .overlay(
                                DatePicker(selection: $newProtocolVM.newPickupProtocol.pickupDate, displayedComponents: .date) {
                                }
                                    .padding(8)
                                    .opacity(0.1)
                            )
                    }
                }
                
                Group {
                    HStack {
                        // MARK: - Signature location
                        TextField("Pickup location", text: $newProtocolVM.newPickupProtocol.signatureLocation)
                            .newProtocolTextInput()
                        
                        // MARK: - Signature date
                        Text(newProtocolVM.newPickupProtocol.signatureDate.formatted(.dateTime.day().month().year()))
                            .dateTextView()
                            .overlay(
                                DatePicker(selection: $newProtocolVM.newPickupProtocol.signatureDate, displayedComponents: .date) {
                                }
                                    .padding(8)
                                    .opacity(0.1)
                            )
                    }
                    
                    // MARK: - Signature
                    Text("Here will be the customer’s signature one day")
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.ultraThinMaterial)
                        )
                    
                    // MARK: - Save button
                    Button {
                        print("I will save the protocol one day.")
                    } label: {
                        Text("SAVE")
                            .saveButton()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding(.top, 32)
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
    }
}

struct AddNewProtocolView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewProtocolView()
    }
}
