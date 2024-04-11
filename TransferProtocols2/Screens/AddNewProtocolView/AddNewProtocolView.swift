//
//  AddNewProtocolView.swift
//  Transfer Protocols
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI
import PhotosUI

enum AddNewProtocolInputs {
    case customerName
    case customerPhone
    case customerEmail
    case itemSpecOne
    case itemSpecTwo
    case handingInSpecOne
    case handingInSpecTwo
    case handingInLocation
    case handingInShopsRepresentativeName
    case signatureLocation
}

struct AddNewProtocolView: View {
    @FocusState private var inputFocused: AddNewProtocolInputs?
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: []) var protocols: FetchedResults<TransferProtocol>
    
    @StateObject private var newProtocolVM = AddNewProtocolViewModel()
    
    @ObservedObject private var mainVM = MainViewModel.shared
    
    @State private var photosPickerItems: [PhotosPickerItem] = []
//    @State private var photos: [UIImage] = []
    
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
                        .focused($inputFocused, equals: .customerName)
                        .submitLabel(.next)
                        .onSubmit {
                            inputFocused = .customerPhone
                        }
                    
                    // MARK: - Customer’s phone number
                    TextField("Customer’s phone number", text: $newProtocolVM.newPickupProtocol.customersPhoneNumber)
                        .newProtocolTextInput()
                        .keyboardType(.phonePad)
                        .focused($inputFocused, equals: .customerPhone)
                        .submitLabel(.next)
                        .onSubmit {
                            inputFocused = .customerEmail
                        }
                    
                    // MARK: - Customer’s email address
                    TextField("Customer’s email address", text: $newProtocolVM.newPickupProtocol.customersEmailAddress)
                        .newProtocolTextInput()
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .focused($inputFocused, equals: .customerEmail)
                        .onSubmit {
                            inputFocused = Optional.none
                        }
                        .submitLabel(.next)
                    
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
                            .focused($inputFocused, equals: .itemSpecOne)
                            .submitLabel(.next)
                            .onSubmit {
                                if let itemSpecificationTitle2 = mainVM.selectedShop?.itemSpecification2Title,
                                   itemSpecificationTitle2.count > 0 {
                                    inputFocused = .itemSpecTwo
                                } else {
                                    inputFocused = .handingInSpecOne
                                }
                            }
                    }
                    
                    // MARK: - Item specification 2
                    if let itemSpecificationTitle2 = mainVM.selectedShop?.itemSpecification2Title,
                       itemSpecificationTitle2.count > 0 {
                        TextField(itemSpecificationTitle2, text: $newProtocolVM.newPickupProtocol.itemSpecification2)
                            .newProtocolTextInput()
                            .focused($inputFocused, equals: .itemSpecTwo)
                            .submitLabel(.next)
                            .onSubmit {
                                if let handingInSpecificationTitle1 = mainVM.selectedShop?.handingInSpecification1Title,
                                   handingInSpecificationTitle1.count > 0 {
                                    inputFocused = .handingInSpecOne
                                } else if let handingInSpecificationTitle2 = mainVM.selectedShop?.handingInSpecification2Title,
                                          handingInSpecificationTitle2.count > 0 {
                                    inputFocused = .handingInSpecTwo
                                } else {
                                    inputFocused = .handingInLocation
                                }
                            }
                    }
                    
                    // MARK: - Handing in specification 1
                    if let handingInSpecificationTitle1 = mainVM.selectedShop?.handingInSpecification1Title,
                       handingInSpecificationTitle1.count > 0 {
                        TextField(handingInSpecificationTitle1, text: $newProtocolVM.newPickupProtocol.handingInSpecification1)
                            .newProtocolTextInput()
                            .focused($inputFocused, equals: .handingInSpecOne)
                            .submitLabel(.next)
                            .onSubmit {
                                if let handingInSpecificationTitle2 = mainVM.selectedShop?.handingInSpecification2Title,
                                   handingInSpecificationTitle2.count > 0 {
                                    inputFocused = .handingInSpecTwo
                                } else {
                                    inputFocused = .handingInLocation
                                }
                            }
                    }
                    
                    // MARK: - Handing in specification 2
                    if let handingInSpecificationTitle2 = mainVM.selectedShop?.handingInSpecification2Title,
                       handingInSpecificationTitle2.count > 0 {
                        TextField(handingInSpecificationTitle2, text: $newProtocolVM.newPickupProtocol.handingInSpecification2)
                            .newProtocolTextInput()
                            .focused($inputFocused, equals: .handingInSpecTwo)
                            .submitLabel(.next)
                            .onSubmit {
                                inputFocused = .handingInLocation
                            }
                    }
                    
                    HStack {
                        // MARK: - Handing in location
                        TextField("Handing in location", text: $newProtocolVM.newPickupProtocol.handingInLocation)
                            .newProtocolTextInput()
                            .focused($inputFocused, equals: .handingInLocation)
                            .submitLabel(.next)
                            .onSubmit {
                                inputFocused = Optional.none
                            }
                        
                        // MARK: - Handing in date
                        Text(newProtocolVM.newPickupProtocol.handingInDate.formatted(.dateTime.day().month().year()))
                            .dateTextView()
                            .overlay(
                                DatePicker(selection: $newProtocolVM.newPickupProtocol.pickupDate, displayedComponents: .date) {
                                }
                                    .padding(8)
                                    .foregroundStyle(.gray)
                                    .opacity(0.1)
                            )
                    }
                }
                
                Group {
                    // MARK: - Handing in shop representative’s name
                    TextField("Shop representative’s name", text: $newProtocolVM.newPickupProtocol.handingInShopsRepresentativeName)
                        .newProtocolTextInput()
                        .focused($inputFocused, equals: .handingInShopsRepresentativeName)
                        .submitLabel(.next)
                        .onSubmit {
                            inputFocused = Optional.none
                        }
                    
                    // MARK: - Add photo
                    PhotosPicker(selection: $photosPickerItems, matching: .images) {
                        HStack {
                            Image(systemName: "plus.square.fill")
                                .opacity(0.5)
                            Text("Add Photo")
                        }
                        .addPhotoButton()
                    }
                    
                    // MARK: - Selected photos
                    if photosPickerItems.count > 0 {
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(0..<newProtocolVM.photos.count, id: \.self) { photoIndex in
                                    Image(uiImage: newProtocolVM.photos[photoIndex])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 150)
                                        .overlay {
                                            VStack {
                                                HStack {
                                                    Spacer()
                                                    Button {
                                                        photosPickerItems.remove(at: photoIndex)
                                                    } label: {
                                                        Image(systemName: "xmark.circle.fill")
                                                            .resizable()
                                                            .frame(width: 16, height: 16)
                                                            .foregroundStyle(.red)
                                                    }
                                                    .background(
                                                        Circle()
                                                            .fill(.white)
                                                    )
                                                    .offset(x: 8, y: -8)
                                                }
                                                Spacer()
                                            }
                                        }
                                }
                            }
                            .padding(.top, 8)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                    }
                }
                
                Group {
                    HStack {
                        // MARK: - Signature location
                        TextField("Signature location", text: $newProtocolVM.newPickupProtocol.signatureLocation)
                            .newProtocolTextInput()
                            .focused($inputFocused, equals: .signatureLocation)
                            .submitLabel(.next)
                            .onSubmit {
                                inputFocused = Optional.none
                            }
                        
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
                        newProtocolVM.saveProtocol(moc: moc)
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
        .onChange(of: photosPickerItems) { value in
            Task {
                newProtocolVM.photos = []
                for photosPickerItem in photosPickerItems {
                    if let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data) {
                            newProtocolVM.photos.append(image)
                        }
                    }
                }
            }
        }
    }
}

struct AddNewProtocolView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewProtocolView()
    }
}
