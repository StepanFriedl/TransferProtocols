//
//  AddNewProtocolViewModel.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 06.01.2024.
//

import SwiftUI

class PickupProtocol: ObservableObject {
    var fullName: String = ""
    var phoneNumber: String = ""
    var emailAddress: String = ""
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
}
