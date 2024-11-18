//
//  ErrorComponentView.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import SwiftUI

struct ErrorComponentView: View {
    @State var error: Error?
    
    var body: some View {
        VStack {
            Text("Error.GeneralError")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
        }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.red.opacity(0.9))
            )
    }
}

#Preview {
    ErrorComponentView()
}
