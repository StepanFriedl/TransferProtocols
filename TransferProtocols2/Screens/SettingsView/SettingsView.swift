//
//  SettingsView.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (spacing: 8) {
                ForEach(1...100, id: \.self) { number in
                    Text("Here will be some settings")
                        .font(.custom(FontsManager.Quicksand.regular, size: 14))
                }
            }
            .padding(.bottom, 70)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 227/255, green: 109/255, blue: 109/255))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
