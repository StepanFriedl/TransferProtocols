//
//  AddNewProtocolViewModel.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 06.01.2024.
//

import SwiftUI
import CoreData

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
    var handingInPlace: String = ""
    var handingInSignaturePlace: String = ""
    var handingInDate: Date = Date.now
    var handingInPerson: String = ""
    
    var carModel: String = ""
    var licencePlate: String = ""
    var visibleDefects: String = ""
    var photos: [Data] = []
    var pickupLocation: String = ""
    @Published var pickupDate: Date = Date.now
    var signatureLocation: String = ""
    @Published var signatureDate: Date = Date.now
    var signature: Data? = nil
}

class AddNewProtocolViewModel: ObservableObject {
    @Published var newPickupProtocol: PickupProtocol = PickupProtocol()

    
//    func saveProtocol() {
//        do {
//            let newProtocol = Protocol(context: moc)
//            newProtocol.itemSpecificationValue1 = newPickupProtocol.itemSpecification1
//            newProtocol.itemSpecificationValue2 = newPickupProtocol.itemSpecification2
//            newProtocol.handingInSpecificationValue1 = newPickupProtocol.handingInSpecification1
//            newProtocol.handingInSpecificationValue2 = newPickupProtocol.handingInSpecification2
////            newProtocol.shop = MainViewModel.shared.selectedShop
//            try moc.save()
//        } catch {
//            // TODO: - Add error alert
//        }
//    }
    
    
}
