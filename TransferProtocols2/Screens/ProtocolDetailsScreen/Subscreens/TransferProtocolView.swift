//
//  TransferProtocolView.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 21.03.2024.
//

import SwiftUI

struct TransferProtocolView: View {
    @StateObject private var mainVM = MainViewModel.shared
    let protocolPictures: FetchedResults<HandingInPicture>
    
    var body: some View {
        VStack {
            // MARK: - Protocol’s title
            Text(mainVM.selectedProtocol?.prototcolTitle ?? "")
                .font(.custom(FontsManager.Quicksand.bold, size: 80))
            
            Text(mainVM.selectedShop?.protocolDescription ?? "")
                .pdfText()
            
            HStack {
                // MARK: - Company
                VStack {
                    Text("Company:")
                        .pdfBigTitle()
                    
                    // name
                    VStack (spacing: 0) {
                        Text("Name:")
                            .pdfTitle()
                        Text(mainVM.selectedProtocol?.shopName ?? "")
                            .pdfText()
                    }
                    
                    // registration number
                    VStack (spacing: 0) {
                        Text("Registration number:")
                            .pdfTitle()
                        Text(mainVM.selectedProtocol?.shopRegistrationNumber ?? "")
                            .pdfText()
                    }
                        
                    // email
                    VStack (spacing: 0) {
                        Text("Email:")
                            .pdfTitle()
                        Text(mainVM.selectedProtocol?.shopEmail ?? "")
                            .pdfText()
                    }
                    
                    // phone number
                    VStack (spacing: 0) {
                        Text("Phone number:")
                            .pdfTitle()
                        Text(mainVM.selectedProtocol?.shopPhoneNumber ?? "")
                    }
                }
                .frame(maxWidth: .infinity)
                
                // MARK: - Customer
                VStack {
                    Text("Customer:")
                        .pdfBigTitle()
                    
                    // name
                    VStack (spacing: 0) {
                        Text("Name:")
                            .pdfTitle()
                        Text(mainVM.selectedProtocol?.customerFullName ?? "")
                            .pdfText()
                    }
                    
                    // date of birth
                    VStack (spacing: 0) {
                        Text("Date of birth:")
                            .pdfTitle()
                        Text(mainVM.selectedProtocol?.customerBirthDate?.toString() ?? "")
                            .pdfText()
                    }
                    
                    // email
                    VStack (spacing: 0) {
                        Text("Email:")
                            .pdfTitle()
                        Text(mainVM.selectedProtocol?.customerEmail ?? "")
                            .pdfText()
                    }
                    
                    // phone number
                    VStack (spacing: 0) {
                        Text("Phone number:")
                            .pdfTitle()
                        Text(mainVM.selectedProtocol?.customerPhoneNumber ?? "")
                            .pdfText()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxHeight: .infinity)

            // MARK: - Item specification
            VStack {
                Text("Item:")
                    .pdfBigTitle()
                if mainVM.selectedProtocol?.itemSpecificationTitle1?.count ?? 0 > 0 {
                    VStack (alignment: .leading, spacing: 0) {
                        Text(mainVM.selectedProtocol?.itemSpecificationTitle1 ?? "")
                            .pdfTitle()
                        Text(mainVM.selectedProtocol?.itemSpecificationValue1 ?? "")
                            .pdfText()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                if mainVM.selectedProtocol?.itemSpecificationTitle2?.count ?? 0 > 0 {
                    VStack (alignment: .leading, spacing: 0) {
                        Text(mainVM.selectedProtocol?.itemSpecificationTitle2 ?? "")
                            .pdfTitle()
                        Text(mainVM.selectedProtocol?.itemSpecificationValue2 ?? "")
                            .pdfText()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxHeight: .infinity)
            
            // MARK: - Handing in specification
            VStack {
                Text("Handing in specification:")
                    .pdfBigTitle()
                
                if mainVM.selectedProtocol?.handingInSpecificationTitle1?.count ?? 0 > 0 {
                    VStack (alignment: .leading, spacing: 0) {
                        Text(mainVM.selectedProtocol?.handingInSpecificationTitle1 ?? "")
                            .pdfTitle()
                        Text(mainVM.selectedProtocol?.handingInSpecificationValue1 ?? "")
                            .pdfText()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                if mainVM.selectedProtocol?.handingInSpecificationTitle2?.count ?? 0 > 0 {
                    VStack (alignment: .leading, spacing: 0) {
                        Text(mainVM.selectedProtocol?.handingInSpecificationTitle2 ?? "")
                            .pdfTitle()
                        Text(mainVM.selectedProtocol?.handingInSpecificationValue2 ?? "")
                            .pdfText()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack (alignment: .leading, spacing: 0) {
                    Text("Handing in place")
                        .pdfTitle()
                    Text(mainVM.selectedProtocol?.handingInPlace ?? "")
                        .pdfText()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack (alignment: .leading, spacing: 0) {
                    Text("Handing in date")
                        .pdfTitle()
                    Text(mainVM.selectedProtocol?.handingInDate?.toString() ?? "")
                        .pdfText()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("Number of photos attached:")
                        .pdfTitle()
                    Text("\(protocolPictures.count)")
                        .pdfText()
                    ForEach(protocolPictures, id: \.self) { protocolPicture in
                        if let pictureData = protocolPicture.pictureData,
                           let uiImage = UIImage(data: pictureData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity)
            
            // MARK: - Handing in signature
            VStack {
                Text("Handing in signature:")
                    .pdfBigTitle()
                
                HStack (alignment: .top) {
                    VStack (spacing: 4) {
                        if let imageData = mainVM.selectedProtocol?.handingInCompanyRepresentativeSignature,
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            Text("No signature")
                                .pdfText()
                        }
                        
                        Text(mainVM.selectedProtocol?.handingInPersonName ?? "")
                            .pdfText()
                        
                        HStack (spacing: 40) {
                            Text(mainVM.selectedProtocol?.handingInDate?.toString() ?? "")
                                .pdfText()
                            Text(mainVM.selectedProtocol?.handingInPlace ?? "")
                                .pdfText()
                        }
                    }
                    
                    VStack (spacing: 4) {
                        if let imageData = mainVM.selectedProtocol?.handingInCustomerSignature,
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            Text("No signature")
                                .pdfText()
                        }
                        
                        Text(mainVM.selectedProtocol?.customerFullName ?? "")
                            .pdfText()
                        
                        HStack (spacing: 40) {
                            Text(mainVM.selectedProtocol?.handingInDate?.toString() ?? "")
                                .pdfText()
                            Text(mainVM.selectedProtocol?.handingInPlace ?? "")
                                .pdfText()
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity)
            
            if mainVM.isProtocolsItemReturned(transferProtocol: mainVM.selectedProtocol) {
                // MARK: - Handing out specification
                if mainVM.selectedProtocol?.handingOutSpecificationTitle1?.count ?? 0 > 0 {
                    VStack (alignment: .leading, spacing: 0) {
                        Text(mainVM.selectedProtocol?.handingOutSpecificationTitle1 ?? "")
                            .pdfTitle()
                        Text(mainVM.selectedProtocol?.handingOutSpecificationValue1 ?? "")
                            .pdfText()
                    }
                    .frame(maxHeight: .infinity)
                }
                
                // MARK: - Handing out signature
                if mainVM.selectedProtocol?.handingOutSpecificationTitle2?.count ?? 0 > 0 {
                    VStack {
                        Text(mainVM.selectedProtocol?.handingOutSpecificationTitle2 ?? "")
                            .pdfTitle()
                        Text(mainVM.selectedProtocol?.handingOutSpecificationValue2 ?? "")
                            .pdfText()
                    }
                    .frame(maxHeight: .infinity)
                }
            } else {
                VStack {}
                    .frame(maxHeight: .infinity)
                VStack {}
                    .frame(maxHeight: .infinity)
            }
        }
        .padding(160)
    }
}
//
//#Preview {
////    TransferProtocolView()
//}
