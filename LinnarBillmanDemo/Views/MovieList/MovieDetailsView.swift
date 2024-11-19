//
//  MovieDetail.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import SwiftUI

struct MovieDetailsView: View {
    @State var movie: Movie
    var body: some View {
        ZStack {
            Color.mainBackground.ignoresSafeArea()
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 0) {
                        Text(movie.name)
                            .font(.largeTitle)
                            .foregroundStyle(Color.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top], 20)
                            .padding([.bottom], 5)
                        
                        HStack(spacing: 0) {
                            Text("MovieDetailsView.Rating")
                                .font(.headline)
                                .foregroundStyle(Color.primary)
                                .padding(.top, 20)
                            Text(String(format: "%.1f", movie.rating))
                                .font(.headline)
                                .foregroundStyle(movie.rating.ratingColor)
                                .padding(.top, 20)
                                .padding(.leading, 10)
                            Spacer()
                        }
                        
                        Text("MovieDetailsView.Plot")
                            .font(.headline)
                            .foregroundStyle(Color.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 20)
                        Text("MovieDetailsView.Lorem")
                            .font(.body)
                            .foregroundStyle(Color.primary)
                            .padding(.top, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                    
                if let imdbUrl = movie.imdbUrl {
                    Link(destination: imdbUrl, label: {
                        PrimaryButton(text: NSLocalizedString("Movie.Detail.Button.Text", comment: ""))
                            .accessibilityIdentifier("imdbButton")
                    }).padding(.bottom, 20)
                }
            }
            .padding(.horizontal, 20)
            
        }
        
    }
}

#Preview {
    MovieDetailsView(movie: Movie(id: 1, name: "Test", rating: 5.4, imdbUrl: nil))
}
