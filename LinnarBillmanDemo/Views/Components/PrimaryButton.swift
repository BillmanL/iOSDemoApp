//
//  PrimaryButton.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import SwiftUI

struct PrimaryButton: View {
    @State var text: String
    var body: some View {
        Text(text)
            .foregroundStyle(Color.buttonPrimaryText)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12).fill(Color.buttonPrimaryBackground)       
            )
    }
}

#Preview {
    PrimaryButton(text: "Button")
}
