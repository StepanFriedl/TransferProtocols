//
//  Extensions.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 28.02.2024.
//

import SwiftUI

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd. MM. yyyy"
        return formatter.string(from: self)
    }
}
