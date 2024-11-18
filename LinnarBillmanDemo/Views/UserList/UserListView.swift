//
//  UserListView.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import SwiftUI

struct UserListView: View {
    @State var users: [User] = []
    @State var error: Error?
    @State var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            Color.mainBackground.ignoresSafeArea()
            VStack {
                if isLoading {
                    ProgressView()
                    Spacer()
                } else {
                    VStack {
                        if let error {
                            ErrorComponentView(error: error).padding(10)
                        }
                        ScrollView {
                            LazyVStack {
                                ForEach(users) { user in
                                    NavigationLink(value: user) {
                                        UserListRow(user: user)
                                    }
                                }
                            }
                        }
                    }.navigationDestination(for: User.self) { user in
                        UserDetailsView(user: user)
                    }
                }
            }
        }.refreshable {
            await fetchUsersInBackground()
        }.task {
            let userDefaultUsers = User.getDataFromUserDefaults()
            if userDefaultUsers.isEmpty {
                /// If we can't find any data in userdefaults, fetch from backend
                do {
                    users = try await User.fetchDataFromBackend()
                    User.saveDataToUserDefaults(users)
                    isLoading = false
                } catch {
                    self.error = error
                    isLoading = false
                }
            } else {
                /// If we do find data in userdefaults, present said data and then fetch data
                /// from backend in backgound to update values
                users = userDefaultUsers
                isLoading = false
                await fetchUsersInBackground()
            }
            isLoading = false
        }.navigationTitle("StartView.UsersButton.Title")
    }
    
    func fetchUsersInBackground() async {
        /// If cached data is too old (in this case 1 day): replace with new data
        var invalidateCache = false
        if let cacheTimeStamp = User.getCacheTimeStamp() {
            let timeDifference = Calendar.current.dateComponents([.day], from: cacheTimeStamp, to: Date()).day ?? 0
            invalidateCache = timeDifference > 1
        }
        
        do {
            let newUsers = try await User.fetchDataFromBackend()
            /// If there is any new/updated data in backend compared to our current data, update.
            if invalidateCache || users != newUsers {
                users = newUsers
                User.saveDataToUserDefaults(users)
            }
        } catch {
            /// In this case i chose to fail silently here. But one could certainly go for a more verbal approach and tell the user the fetching failed
        }
    }
}

#Preview {
    UserListView()
}
