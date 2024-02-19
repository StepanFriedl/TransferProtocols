//
//  DataController.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 19.02.2024.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "TransferProtocols")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                // TODO: - Add an error handling
                print(error.localizedDescription)
            }
        }
    }
}
