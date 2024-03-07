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
    
    @StateObject private var newProtocolVM = AddNewProtocolViewModel()
    
    @ObservedObject private var mainVM = MainViewModel.shared
    
    var body: some View {
        // MARK: - Main View
        ScrollView (showsIndicators: false) {
            VStack (alignment: .leading, spacing: 25) {
                Text("Customer")
                    .font(.custom(FontsManager.Quicksand.semiBold, size: 16))
                
                Group {
                    // MARK: - Customer’s full name
                    TextField("Customer’s full name", text: $newProtocolVM.newPickupProtocol.customersFullName)
                        .newProtocolTextInput()
                    
                    // MARK: - Customer’s phone number
                    TextField("Customer’s phone number", text: $newProtocolVM.newPickupProtocol.customersPhoneNumber)
                        .newProtocolTextInput()
                        .keyboardType(.phonePad)
                    
                    // MARK: - Customer’s email address
                    TextField("Customer’s email address", text: $newProtocolVM.newPickupProtocol.customersEmailAddress)
                        .newProtocolTextInput()
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    
                    // MARK: - Customer’s birth date
                    HStack {
                        Text("Customer’s birth date:")
                        
                        Spacer()
                        
                        Text(newProtocolVM.newPickupProtocol.customersBirthDate.formatted(.dateTime.day().month().year()))
                            .dateTextView()
                            .overlay(
                                DatePicker(selection: $newProtocolVM.newPickupProtocol.customersBirthDate, displayedComponents: .date) {}
                                    .padding(8)
                                    .foregroundStyle(.gray)
                                    .opacity(0.1)
                            )
                    }
                }
                
                // MARK: - Protocol’s title
                if let protocolTitle = mainVM.selectedShop?.transferProtocolTitle {
                    Text(protocolTitle)
                        .font(.custom(FontsManager.Quicksand.semiBold, size: 16))
                }
                
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
                    
                    HStack {
                        // MARK: - Pickup location
                        TextField("Handing in location", text: $newProtocolVM.newPickupProtocol.pickupLocation)
                            .newProtocolTextInput()
                        
                        // MARK: - Pickup date
                        Text(newProtocolVM.newPickupProtocol.pickupDate.formatted(.dateTime.day().month().year()))
                            .dateTextView()
                            .overlay(
                                DatePicker(selection: $newProtocolVM.newPickupProtocol.pickupDate, displayedComponents: .date) {
                                }
                                    .padding(8)
                                    .foregroundStyle(.gray)
                                    .opacity(0.1)
                            )
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
                }
                
                Group {
                    HStack {
                        // MARK: - Signature location
                        TextField("Signature location", text: $newProtocolVM.newPickupProtocol.signatureLocation)
                            .newProtocolTextInput()
                        
                        // MARK: - Signature date
                        Text(newProtocolVM.newPickupProtocol.signatureDate.formatted(.dateTime.day().month().year()))
                            .dateTextView()
                            .overlay(
                                DatePicker(selection: $newProtocolVM.newPickupProtocol.signatureDate, displayedComponents: .date) {
                                }
                                    .padding(8)
                                    .foregroundStyle(.gray)
                                    .opacity(0.1)
                            )
                    }
                    
                    // MARK: - Customer’s signature
                    ZStack {
                        if let signatureData = self.newProtocolVM.newPickupProtocol.handingInCustomerSignature,
                           let uiImage = UIImage(data: signatureData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(600/250, contentMode: .fit)
                                .frame(maxWidth: .infinity)
                        } else {
                            Text("Tap to add a customer’s signature.")
                                .font(.custom(FontsManager.Quicksand.regular, size: 20))
                                .opacity(0.5)
                        }
                    }
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.ultraThinMaterial)
                    )
                    .onTapGesture {
                        mainVM.signView = SignatureView(closeViewAction: { signatureImage in
                            self.newProtocolVM.newPickupProtocol.handingInCustomerSignature = signatureImage.pngData()
                            mainVM.showSignatureView = false
                        })
                        mainVM.showSignatureView = true
                    }
                    
                    // MARK: - Company representative’s signature
                    ZStack {
                        if let signatureData = self.newProtocolVM.newPickupProtocol.handingInCompanyRepresentativeSignature,
                           let uiImage = UIImage(data: signatureData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(600/250, contentMode: .fit)
                                .frame(maxWidth: .infinity)
                        } else {
                            Text("Tap to add a company representative’s signature.")
                                .font(.custom(FontsManager.Quicksand.regular, size: 20))
                                .opacity(0.5)
                        }
                    }
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.ultraThinMaterial)
                    )
                    .onTapGesture {
                        mainVM.signView = SignatureView(closeViewAction: { signatureImage in
                            self.newProtocolVM.newPickupProtocol.handingInCompanyRepresentativeSignature = signatureImage.pngData()
                            mainVM.showSignatureView = false
                        })
                        mainVM.showSignatureView = true
                    }
                    
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
    }
    
    func saveProtocol() {
        do {
            guard let selectedShop = mainVM.selectedShop else { return }
            let newProtocol = TransferProtocol(context: moc)
            newProtocol.shopPhoneNumber = selectedShop.phoneNumber ?? ""
            newProtocol.shopRegistrationNumber = selectedShop.registrationNumber ?? ""
            newProtocol.shopName = selectedShop.companyName ?? ""
            newProtocol.shopLogoImage = selectedShop.logoImage ?? Data()
            newProtocol.shopEmail = selectedShop.email ?? ""
            newProtocol.prototcolTitle = selectedShop.transferProtocolTitle
            newProtocol.itemSpecificationTitle1 = selectedShop.itemSpecification1Title
            newProtocol.itemSpecificationTitle2 = selectedShop.itemSpecification2Title
            newProtocol.itemSpecificationValue1 = newProtocolVM.newPickupProtocol.itemSpecification1
            newProtocol.itemSpecificationValue2 = newProtocolVM.newPickupProtocol.itemSpecification2
            newProtocol.handingOutSpecificationTitle1 = selectedShop.handingOutSpecification1Title
            newProtocol.handingOutSpecificationTitle2 = selectedShop.handingOutSpecification2Title
            newProtocol.handingOutSpecificationValue1 = newProtocolVM.newPickupProtocol.handingOutSpecification1
            newProtocol.handingOutSpecificationValue2 = newProtocolVM.newPickupProtocol.handingOutSpecification2
            newProtocol.handingOutPlace = nil
            newProtocol.handingOutDate = nil
            newProtocol.handingOutCustomerSignature = nil
            newProtocol.handingOutCompanyRepresentativeSignature = nil
            newProtocol.handingInSpecificationTitle1 = selectedShop.handingInSpecification1Title
            newProtocol.handingInSpecificationTitle2 = selectedShop.handingInSpecification2Title
            newProtocol.handingInSpecificationValue1 = newProtocolVM.newPickupProtocol.handingInSpecification1
            newProtocol.handingInSpecificationValue2 = newProtocolVM.newPickupProtocol.handingInSpecification2
            newProtocol.handingInPlace = newProtocolVM.newPickupProtocol.handingInPlace
            newProtocol.handingInPersonName = newProtocolVM.newPickupProtocol.handingInPerson
            newProtocol.handingInDate = newProtocolVM.newPickupProtocol.handingInDate
            newProtocol.handingInCustomerSignature = newProtocolVM.newPickupProtocol.handingInCustomerSignature ?? Data()
            newProtocol.handingInCompanyRepresentativeSignature = newProtocolVM.newPickupProtocol.handingInCompanyRepresentativeSignature ?? Data()
            newProtocol.handedOut = nil
            newProtocol.customerPhoneNumber = newProtocolVM.newPickupProtocol.customersPhoneNumber
            newProtocol.customerFullName = newProtocolVM.newPickupProtocol.customersFullName
            newProtocol.customerEmail = newProtocolVM.newPickupProtocol.customersEmailAddress
            newProtocol.customerBirthDate = newProtocolVM.newPickupProtocol.customersBirthDate
            newProtocol.created = Date.now
            newProtocol.handingOutPersonName = newProtocolVM.newPickupProtocol.handingOutPersonName
            
            newProtocol.shop = MainViewModel.shared.selectedShop
            
            try moc.save()
            
            mainVM.shopScreensPage = .allProtocols
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
