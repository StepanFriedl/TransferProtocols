//
//  PhoneNumberLink.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 28.02.2024.
//

import SwiftUI

enum LinkType {
    case phoneNumber
    case emailAddress
}

struct ContactLink: View {
    let linkType: LinkType
    let contactValue: String
    
    var body: some View {
        Button {
            var urlString = ""
            switch linkType {
            case .phoneNumber:
                urlString = "tel://\(contactValue.replacingOccurrences(of: " ", with: ""))"
            case .emailAddress:
                urlString = "mailto://\(contactValue.trimmingCharacters(in: .whitespacesAndNewlines) )"
            }
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            } else {
                // TODO: - Add error handling
            }
        } label: {
            Text(contactValue)
                .foregroundStyle(.blue)
                .underline()
        }
    }
}

#Preview {
    ContactLink(
        linkType: .phoneNumber,
            contactValue: "777666555"
    )
}
