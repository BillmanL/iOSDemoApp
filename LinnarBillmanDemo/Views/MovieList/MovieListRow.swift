//
//  MovieListRow.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import SwiftUI

struct MovieListRow: View {
    @State var movie: Movie
    
    var body: some View {
        HStack(spacing: 0) {
            Text(movie.name)
                .font(.headline)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(15)
                
            Spacer()
            
            Text(String(format: "%.1f", movie.rating))
                .font(.headline)
                .foregroundStyle(movie.rating.ratingColor)
            Image(systemName: "star.fill")
                .foregroundStyle(Color.yellow)
                .padding(.trailing, 15)
                .padding(.leading, 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 4).fill(.listItemBackground)
        )
        
    }
}

#Preview {
    MovieListRow(movie: Movie(id: 1, name: "Test", rating: 5.4, imdbUrl: nil))
}
