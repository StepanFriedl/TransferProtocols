//
//  HandOutProtocolScreen.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 10.03.2024.
//

import SwiftUI
import PhotosUI

enum HandOutProtocolInputs {
    case specificationOne
    case specificationTwo
    case location
    case signatureLocation
    case customerName
    case shopRepresentativeName
}

struct HandOutProtocolScreen: View {
    @FocusState private var inputFocused: HandOutProtocolInputs?
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject private var mainVM = MainViewModel.shared
    @StateObject private var handingOutVM = HandingOutViewModel()
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (alignment: .leading, spacing: 25) {
                // MARK: - Handing out specification 1
                if let handingOutSpecificationTitle1 = mainVM.selectedShop?.handingOutSpecification1Title,
                   handingOutSpecificationTitle1.count > 0 {
                    TextField(handingOutSpecificationTitle1, text: $handingOutVM.handingOutProtocol.handingOutSpecification1)
                        .newProtocolTextInput()
                        .focused($inputFocused, equals: .specificationOne)
                        .submitLabel(.next)
                        .onSubmit {
                            if let handingOutSpecificationTitle2 = mainVM.selectedShop?.handingOutSpecification2Title,
                               handingOutSpecificationTitle2.count > 0 {
                                inputFocused = .specificationTwo
                            } else {
                                inputFocused = Optional.none
                            }
                        }
                }
                
                // MARK: - Handing out specification 2
                if let handingOutSpecificationTitle2 = mainVM.selectedShop?.handingOutSpecification2Title,
                   handingOutSpecificationTitle2.count > 0 {
                    TextField(handingOutSpecificationTitle2, text: $handingOutVM.handingOutProtocol.handingOutSpecification2)
                        .newProtocolTextInput()
                        .focused($inputFocused, equals: .specificationTwo)
                        .submitLabel(.next)
                        .onSubmit {
                            inputFocused = Optional.none
                        }
                }
                
                // MARK: - Handing out photos
                // Add photo
                PhotosPicker(selection: $handingOutVM.photosPickerItems, matching: .images) {
                    HStack {
                        Image(systemName: "plus:square.fill")
                            .opacity(0.5)
                        Text("Add Photo")
                    }
                    .addPhotoButton()
                }
                // Selected photos
                if handingOutVM.photosPickerItems.count > 0 {
                    ScrollView (.horizontal) {
                        HStack {
                            ForEach(0..<handingOutVM.photos.count, id: \.self) { photoIndex in
                                Image(uiImage: handingOutVM.photos[photoIndex])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 150)
                                    .overlay {
                                        VStack {
                                            HStack {
                                                Spacer()
                                                Button { handingOutVM.photosPickerItems.remove(at: photoIndex)
                                                } label: {
                                                    Image(systemName: "xmark.circle.fill")
                                                        .resizable()
                                                        .frame(width: 16, height: 16)
                                                        .foregroundStyle(.red)
                                                        .background(
                                                            Circle()
                                                                .fill(.white)
                                                                .offset(x: 8, y: -8)
                                                        )
                                                }
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
                
                HStack {
                    // MARK: - Handing out location
                    TextField("Handing out location", text: $handingOutVM.handingOutProtocol.handingOutPlace)
                        .newProtocolTextInput()
                        .focused($inputFocused, equals: .location)
                        .submitLabel(.next)
                        .onSubmit {
                            inputFocused = Optional.none
                        }
                    
                    // MARK: - Handing out date
                    Text(handingOutVM.handingOutProtocol.handingOutDate.formatted( .dateTime.day().month().year()))
                        .dateTextView()
                        .overlay(
                            DatePicker(selection: $handingOutVM.handingOutProtocol.handingOutDate, displayedComponents: .date) {}
                                .padding(8)
                                .foregroundStyle(.gray)
                                .opacity(0.1)
                        )
                }
                
                HStack {
                    // MARK: - Handing out signature location
                    TextField("Signature location", text: $handingOutVM.handingOutProtocol.handingOutSignatureLocation)
                        .newProtocolTextInput()
                        .focused($inputFocused, equals: .signatureLocation)
                        .submitLabel(.next)
                        .onSubmit {
                            inputFocused = Optional.none
                        }
                    
                    // MARK: - Handing out signature date
                    Text(handingOutVM.handingOutProtocol.handingOutSignatureDate.formatted( .dateTime.day().month().year()))
                        .dateTextView()
                        .overlay(
                            DatePicker(selection: $handingOutVM.handingOutProtocol.handingOutSignatureDate, displayedComponents: .date) {}
                                .padding(8)
                                .foregroundStyle(.gray)
                                .opacity(0.1)
                        )
                }

                // MARK: - Handing out customer’s name
                TextField("Customer’s name", text: $handingOutVM.handingOutProtocol.handingOutCustomerName)
                    .newProtocolTextInput()
                    .focused($inputFocused, equals: .customerName)
                    .submitLabel(.next)
                    .onSubmit {
                        inputFocused = Optional.none
                    }
                
                // MARK: - Handing out customer’s signature
                ZStack {
                    if let signatureData = self.handingOutVM.handingOutProtocol.handingOutCustomerSignature,
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
                        self.handingOutVM.handingOutProtocol.handingOutCustomerSignature = signatureImage.pngData()
                        mainVM.showSignatureView = false
                    })
                    mainVM.showSignatureView = true
                }
                
                // MARK: - Handing out company representative’s name
                TextField("Shop representative’s name", text: $handingOutVM.handingOutProtocol.handingOutCompanyRepresentativeName)
                    .newProtocolTextInput()
                    .focused($inputFocused, equals: .shopRepresentativeName)
                    .submitLabel(.next)
                    .onSubmit {
                        inputFocused = Optional.none
                    }
                
                // MARK: - Handing out company representative’s signature
                ZStack {
                    if let signatureData = self.handingOutVM.handingOutProtocol.handingOutCompanyRepresentativeSignature,
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
                        self.handingOutVM.handingOutProtocol.handingOutCompanyRepresentativeSignature = signatureImage.pngData()
                        mainVM.showSignatureView = false
                    })
                    mainVM.showSignatureView = true
                }
                
                // MARK: - Save button
                Button {
                    handingOutVM.saveHandingOutProtocol(moc: moc)
                    mainVM.shopScreensPage = .protocolDetails
                } label: {
                    Text("SAVE")
                        .saveButton()
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.top, 32)
            .padding(.bottom, 300)
        }
        .padding(.horizontal, 32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onChange(of: handingOutVM.photosPickerItems) { value in
            Task {
                handingOutVM.photos = []
                for photosPickerItem in handingOutVM.photosPickerItems {
                    if let data = try? await photosPickerItem.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        handingOutVM.photos.append(image)
                    }
                }
            }
        }
    }
}

#Preview {
    HandOutProtocolScreen()
}
