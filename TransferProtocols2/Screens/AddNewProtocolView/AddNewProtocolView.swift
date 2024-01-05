//
//  AddNewProtocolView.swift
//  Transfer Protocols
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

struct AddNewProtocolView: View {
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack {
                ForEach(1...100, id: \.self) { number in
                    VStack (alignment: .leading, spacing: 10) {
                        Text("This will be input field \(number):")
                        
                        Rectangle()
                            .stroke(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 20)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
                }
            }
            .padding(.bottom, 70)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 164/255, green: 191/255, blue: 145/255))
    }
}

struct AddNewProtocolView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewProtocolView()
    }
}
