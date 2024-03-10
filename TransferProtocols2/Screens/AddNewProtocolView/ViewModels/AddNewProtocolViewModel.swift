//
//  AddNewProtocolViewModel.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 06.01.2024.
//

import SwiftUI
import CoreData

class AddNewProtocolViewModel: ObservableObject {
    @Published var newPickupProtocol: PickupProtocol = PickupProtocol()
    
    var mainVM = MainViewModel.shared
    @Published var photos: [UIImage] = []
    
    func saveProtocol(moc: NSManagedObjectContext) {
        do {
            guard let selectedShop = self.mainVM.selectedShop else { return }
            let newProtocol = TransferProtocol(context: moc)
            newProtocol.shopPhoneNumber = selectedShop.phoneNumber ?? ""
            newProtocol.shopRegistrationNumber = selectedShop.registrationNumber ?? ""
            newProtocol.shopName = selectedShop.companyName ?? ""
            newProtocol.shopLogoImage = selectedShop.logoImage ?? Data()
            newProtocol.shopEmail = selectedShop.email ?? ""
            newProtocol.prototcolTitle = selectedShop.transferProtocolTitle
            newProtocol.itemSpecificationTitle1 = selectedShop.itemSpecification1Title
            newProtocol.itemSpecificationTitle2 = selectedShop.itemSpecification2Title
            newProtocol.itemSpecificationValue1 = self.newPickupProtocol.itemSpecification1
            newProtocol.itemSpecificationValue2 = self.newPickupProtocol.itemSpecification2
            newProtocol.handingOutSpecificationTitle1 = selectedShop.handingOutSpecification1Title
            newProtocol.handingOutSpecificationTitle2 = selectedShop.handingOutSpecification2Title
            newProtocol.handingOutSpecificationValue1 = self.newPickupProtocol.handingOutSpecification1
            newProtocol.handingOutSpecificationValue2 = self.newPickupProtocol.handingOutSpecification2
            newProtocol.handingOutPlace = nil
            newProtocol.handingOutDate = nil
            newProtocol.handingOutCustomerSignature = nil
            newProtocol.handingOutCompanyRepresentativeSignature = nil
            newProtocol.handingInSpecificationTitle1 = selectedShop.handingInSpecification1Title
            newProtocol.handingInSpecificationTitle2 = selectedShop.handingInSpecification2Title
            newProtocol.handingInSpecificationValue1 = self.newPickupProtocol.handingInSpecification1
            newProtocol.handingInSpecificationValue2 = self.newPickupProtocol.handingInSpecification2
            newProtocol.handingInPlace = self.newPickupProtocol.handingInPlace
            newProtocol.handingInPersonName = self.newPickupProtocol.handingInPerson
            newProtocol.handingInDate = self.newPickupProtocol.handingInDate
            newProtocol.handingInCustomerSignature = self.newPickupProtocol.handingInCustomerSignature ?? Data()
            newProtocol.handingInCompanyRepresentativeSignature = self.newPickupProtocol.handingInCompanyRepresentativeSignature ?? Data()
            newProtocol.handedOut = nil
            newProtocol.customerPhoneNumber = self.newPickupProtocol.customersPhoneNumber
            newProtocol.customerFullName = self.newPickupProtocol.customersFullName
            newProtocol.customerEmail = self.newPickupProtocol.customersEmailAddress
            newProtocol.customerBirthDate = self.newPickupProtocol.customersBirthDate
            newProtocol.created = Date.now
            newProtocol.handingOutCustomerName = ""
            newProtocol.handingOutCompanyRepresentativeName = ""
            
            newProtocol.shop = MainViewModel.shared.selectedShop

            saveProtocolPictures(transferProtocol: newProtocol)
            
            try moc.save()
            
            mainVM.shopScreensPage = .allProtocols
        } catch {
            // TODO: - Add error alert
        }
        
        func saveProtocolPictures(transferProtocol: TransferProtocol) {
            for picture in photos {
                if let pictureData = picture.pngData() {
                    let newPicture = HandingInPicture(context: moc)
                    newPicture.id = UUID()
                    newPicture.pictureData = pictureData
                    newPicture.transferProtocol = transferProtocol
                }
            }
        }
    }
}

class PickupProtocol: ObservableObject {
    var customersFullName: String = ""
    var customersPhoneNumber: String = ""
    var customersEmailAddress: String = ""
    var customersBirthDate: Date = Date.now
    
    var itemSpecification1: String = ""
    var itemSpecification2: String = ""
    var handingInSpecification1: String = ""
    var handingInSpecification2: String = ""
    var handingOutSpecification1: String = ""
    var handingOutSpecification2: String = ""
    var handingInShopsRepresentativeName: String = ""
    var handingOutPersonName: String = ""
    var handingInPlace: String = ""
    var handingInDate: Date = Date.now
    var handingInPerson: String = ""
    @Published var handingInCustomerSignature: Data? = nil
    @Published var handingInCompanyRepresentativeSignature: Data? = nil
    
    var handingInLocation: String = ""
    @Published var pickupDate: Date = Date.now
    var signatureLocation: String = ""
    @Published var signatureDate: Date = Date.now
    var signature: Data? = nil
}
