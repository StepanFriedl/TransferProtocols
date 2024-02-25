//
//  AddNewProtocolView.swift
//  Transfer Protocols
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

struct AddNewProtocolView: View {
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: []) var protocols: FetchedResults<TransferProtocol>
    
    @ObservedObject private var newProtocolVM = AddNewProtocolViewModel()
    
    @ObservedObject private var mainVM = MainViewModel.shared
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (alignment: .leading, spacing: 25) {
                
                // MARK: - Protocol’s title
                if let protocolTitle = mainVM.selectedShop?.transferProtocolTitle {
                    Text(protocolTitle)
                }
                
//                Group {
//                    // MARK: - Customer’s full name
//                    TextField("Customer’s full name", text: $newProtocolVM.newPickupProtocol.fullName)
//                        .newProtocolTextInput()
//                    
//                    // MARK: - Customer’s phone number
//                    TextField("Customer’s phone number", text: $newProtocolVM.newPickupProtocol.phoneNumber)
//                        .newProtocolTextInput()
//                        .keyboardType(.phonePad)
//                    
//                    // MARK: - Customer’s email address
//                    TextField("Customer’s email address", text: $newProtocolVM.newPickupProtocol.emailAddress)
//                        .newProtocolTextInput()
//                        .keyboardType(.emailAddress)
//                        .textInputAutocapitalization(.never)
//                }
                
                Group {
                    // MARK: - Item specification 1
                    if let itemSpecificationTitle1 = mainVM.selectedShop?.itemSpecification1Title,
                       itemSpecificationTitle1.count > 0 {
                        TextField(itemSpecificationTitle1, text: $newProtocolVM.newPickupProtocol.itemSpecification1)
                            .newProtocolTextInput()
                    }
                    
                    // MARK: - Item specification 2
                    if let itemSpecificationTitle2 = mainVM.selectedShop?.itemSpecification2Title,
                       itemSpecificationTitle2.count > 0 {
                        TextField(itemSpecificationTitle2, text: $newProtocolVM.newPickupProtocol.itemSpecification2)
                            .newProtocolTextInput()
                    }
                    
                    // MARK: - Handing in specification 1
                    if let handingInSpecificationTitle1 = mainVM.selectedShop?.handingInSpecification1Title,
                       handingInSpecificationTitle1.count > 0 {
                        TextField(handingInSpecificationTitle1, text: $newProtocolVM.newPickupProtocol.handingInSpecification1)
                            .newProtocolTextInput()
                    }
                    
                    // MARK: - Handing in specification 2
                    if let handingInSpecificationTitle2 = mainVM.selectedShop?.handingInSpecification2Title,
                       handingInSpecificationTitle2.count > 0 {
                        // MARK: - Handing in specification 1
                        TextField(handingInSpecificationTitle2, text: $newProtocolVM.newPickupProtocol.handingInSpecification2)
                            .newProtocolTextInput()
                    }
                    
                    // MARK: - Handing in shop representative’s name
                    TextField("Shop representative’s name", text: $newProtocolVM.newPickupProtocol.handingInShopsRepresentativeName)
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
                        saveProtocol()
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
    
    func saveProtocol() {
        do {
            let newProtocol = TransferProtocol(context: moc)
            newProtocol.shopPhoneNumber = "a"
            newProtocol.shopPhoneNumber = "a"
            newProtocol.shopName = "a"
            newProtocol.shopLogoImage = Data()
            newProtocol.shopEmail = "a"
            newProtocol.prototcolTitle = "a"
            newProtocol.itemSpecificationValue2 = "a"
            newProtocol.itemSpecificationValue1 = "a"
            newProtocol.itemSpecificationTitle1 = "a"
            newProtocol.itemSpecificationTitle2 = "a"
            newProtocol.handingOutSpecificationValue1 = "a"
            newProtocol.handingOutSpecificationValue2 = "a"
            newProtocol.handingOutSpecificationTitle1 = "a"
            newProtocol.handingOutSpecificationTitle2 = "a"
            newProtocol.handingOutPlace = "a"
            newProtocol.handingOutDate = Date.now
            newProtocol.handingOutCustomerSignature = Data()
            newProtocol.handingOutCompanyRepresentativeSignature = Data()
            newProtocol.handingInSpecificationTitle1 = "a"
            newProtocol.handingInSpecificationTitle2 = "a"
            newProtocol.handingInSpecificationValue1 = "a"
            newProtocol.handingInSpecificationValue2 = "a"
            newProtocol.handingInSignaturePlace = "a"
            newProtocol.handingInPlace = "a"
            newProtocol.handingInPersonName = "a"
            newProtocol.handingInDate = Date()
            newProtocol.handingInCustomerSignature = Data()
            newProtocol.handingInCompanyRepresentativeSignature = Data()
            newProtocol.handedOut = Date()
            newProtocol.customerPhoneNumber = "a"
            newProtocol.customerFullName = "a"
            newProtocol.customerEmail = "a"
            newProtocol.customerBirthDate = Date()
            newProtocol.created = Date.now
            
            
            newProtocol.shop = MainViewModel.shared.selectedShop
//            newProtocol.shop = MainViewModel.shared.selectedShop
            
            try moc.save()
        } catch {
            // TODO: - Add error alert
        }
    }
}

struct AddNewProtocolView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewProtocolView()
    }
}
