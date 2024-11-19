//
//  ErrorComponentView.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import SwiftUI

struct ErrorComponentView: View {
    @State var error: Error?
    @Binding var showError: Bool
    
    var body: some View {
        HStack {
            Text("Error.GeneralError")
                .font(.headline)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Spacer()
            Button {
                showError = false
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(Color.white)
                    .padding()
            }
        }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.red.opacity(0.9))
            )
    }
}
