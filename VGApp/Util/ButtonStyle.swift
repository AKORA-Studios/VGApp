//
//  ButtonStyle.swift
//  VGApp
//
//  Created by Kiara on 08.10.24.
//

import SwiftUI

struct RecycleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.accentColor)
            .foregroundStyle(.black)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(width: 40, height: 40)
    }
}

struct RecycleOptionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.accentColor)
            .foregroundStyle(.black)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
