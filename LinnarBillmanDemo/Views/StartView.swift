//
//  ContentView.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import SwiftUI

struct StartView: View {
    @State var showView: Bool = false
    @State var showLaunchScreenBackground: Bool = true
    var body: some View {
        NavigationStack {
            if showView {
                ZStack {
                    Color.mainBackground.ignoresSafeArea().zIndex(0)
                    VStack {
                        ScrollView {
                            VStack(spacing: 0) {
                                Text("StartView.Title")
                                    .font(.largeTitle)
                                    .foregroundStyle(Color.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.top], 30)
                                    .padding([.bottom], 5)
                                
                                Text("StartView.Description")
                                    .font(.body)
                                    .foregroundStyle(Color.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.top], 20)
                                
                                
                                Text("StartView.Header1")
                                    .font(.headline)
                                    .foregroundStyle(Color.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 20)
                                Text("StartView.Body1")
                                    .font(.body)
                                    .foregroundStyle(Color.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 2)
                                
                                Text("StartView.Header2")
                                    .font(.headline)
                                    .foregroundStyle(Color.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 20)
                                Text("StartView.Body2")
                                    .font(.body)
                                    .foregroundStyle(Color.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 2)
                                    
                            }.padding([.horizontal], 20)
                        }
                        NavigationLink(value: 0) {
                            PrimaryButton(text: NSLocalizedString("StartView.MoviesButton.Title", comment: ""))
                                .accessibilityIdentifier("moviesButton")
                                .padding([.horizontal], 20)
                                .padding([.vertical], 10)
                        }
                        NavigationLink(value: 1) {
                            PrimaryButton(text: NSLocalizedString("StartView.UsersButton.Title", comment: ""))
                                .accessibilityIdentifier("usersButton")
                                .padding([.horizontal], 20)
                                .padding([.bottom], 20)
                        }
                    }.navigationDestination(for: Int.self) { int in
                        switch int {
                        case 0:
                            MovieListView()
                        default:
                            UserListView()
                        }
                        
                    }
                }
                .zIndex(1)
                
            } else {
                if showLaunchScreenBackground {
                    Color("launchscreen-color").ignoresSafeArea()
                }
            }
            
                    
            
        }.onAppear {
            withAnimation(.easeIn(duration: 0.3), {
                showLaunchScreenBackground = false
            }, completion: {
                withAnimation(.easeIn(duration: 0.3)) {
                    showView = true
                }
            })
        }.accentColor(.primary)
    }
}

#Preview {
    StartView()
}
