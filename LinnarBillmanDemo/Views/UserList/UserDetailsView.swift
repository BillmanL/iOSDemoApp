//
//  UserDetailsView.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import SwiftUI

struct UserDetailsView: View {
    @State var user: User
    var body: some View {
        ZStack {
            Color.mainBackground.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 0) {
                    Text(user.name)
                        .font(.largeTitle)
                        .foregroundStyle(Color.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top], 20)
                        .padding([.bottom], 5)
                    Text("\(user.email)")
                        .font(.headline)
                        .foregroundStyle(Color.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top], 10)
                        .padding([.bottom], 5)
                    
                    if let address = user.address {
                        Text("\(address.street)")
                            .font(.body)
                            .foregroundStyle(Color.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top], 10)
                        Text("\(address.zipcode) \(address.state)")
                            .font(.body)
                            .foregroundStyle(Color.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(address.city)")
                            .font(.body)
                            .foregroundStyle(Color.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal, 20)
            }
            
        }.navigationTitle(user.name)
        
    }
}

#Preview {
    UserDetailsView(user: User(id: 1, name: "Test Tester", username: "Test", email: "test@test.com", address: nil))
}
