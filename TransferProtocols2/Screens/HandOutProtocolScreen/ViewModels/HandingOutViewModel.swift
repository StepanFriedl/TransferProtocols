//
//  HandingOutViewModel.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 10.03.2024.
//

import SwiftUI
import CoreData
import PhotosUI

class HandingOutViewModel: ObservableObject {
    @Published var photos: [UIImage] = []
    @Published var handingOutProtocol: HandingOutProtocol = HandingOutProtocol()
    var mainVM = MainViewModel.shared
    @Published var photosPickerItems: [PhotosPickerItem] = []
    
    func saveHandingOutProtocol(moc: NSManagedObjectContext) {
        do {
            mainVM.selectedProtocol?.handingOutSpecificationValue1 = self.handingOutProtocol.handingOutSpecification1
            mainVM.selectedProtocol?.handingOutSpecificationValue2 = self.handingOutProtocol.handingOutSpecification2
            
            mainVM.selectedProtocol?.handingOutPlace = self.handingOutProtocol.handingOutPlace
            mainVM.selectedProtocol?.handingOutDate = self.handingOutProtocol.handingOutDate
            
            
            mainVM.selectedProtocol?.handingOutSignatureLocation = self.handingOutProtocol.handingOutSignatureLocation
            mainVM.selectedProtocol?.handingOutSignatureDate = self.handingOutProtocol.handingOutSignatureDate
            
            
            mainVM.selectedProtocol?.handingOutCustomerName = self.handingOutProtocol.handingOutCustomerName
            mainVM.selectedProtocol?.handingOutCustomerSignature = self.handingOutProtocol.handingOutCustomerSignature

            mainVM.selectedProtocol?.handingOutCompanyRepresentativeName = self.handingOutProtocol.handingOutCompanyRepresentativeName
            mainVM.selectedProtocol?.handingOutCompanyRepresentativeSignature = self.handingOutProtocol.handingOutCompanyRepresentativeSignature
            try moc.save()
        } catch {
            // TODO: - Add error alert
            print("fak")
        }
    }
}

class HandingOutProtocol: ObservableObject {
    var handingOutSpecification1: String = ""
    var handingOutSpecification2: String = ""
    
    var handingOutPlace: String = ""
    var handingOutDate: Date = Date.now
    
    var handingOutSignatureLocation: String = ""
    var handingOutSignatureDate: Date = Date.now
    
    var handingOutCustomerName: String = ""
    @Published var handingOutCustomerSignature: Data? = nil
    
    var handingOutCompanyRepresentativeName: String = ""
    @Published var handingOutCompanyRepresentativeSignature: Data? = nil
}
