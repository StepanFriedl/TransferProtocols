//
//  ProtocolDetailsScreen.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

struct ProtocolDetailsScreen: View {
    @ObservedObject private var mainVM = MainViewModel.shared
    
    var body: some View {
        VStack {
            Text(mainVM.presentedProtocol)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 248/255, green: 255/255, blue: 122/255))
    }
}

struct ProtocolDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolDetailsScreen()
    }
}
