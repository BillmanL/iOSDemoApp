//
//  UserListRow.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import SwiftUI

struct UserListRow: View {
    @State var user: User
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                Text(user.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding([.horizontal], 15)
                Text(user.email)
                    .font(.caption)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding([.horizontal], 15)
            }.padding([.vertical], 15)
            
                
            Spacer()
            
            Text(user.address?.city ?? "")
                .font(.body)
                .foregroundStyle(.primary)
                .padding(15)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 4).fill(.listItemBackground)
        )
    }
}

#Preview {
    UserListRow(user: User(id: 1, name: "Test Tester", username: "Test", email: "test@test.com", address: nil))
}
