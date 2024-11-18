//
//  MovieListView.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import SwiftUI

struct MovieListView: View {
    @State var movies: [Movie] = []
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
                                ForEach(movies) { movie in
                                    NavigationLink(value: movie) {
                                        MovieListRow(movie: movie)
                                    }
                                }
                            }
                        }
                    }.navigationDestination(for: Movie.self) { movie in
                        MovieDetailsView(movie: movie)
                    }
                }
            }
        }.refreshable {
            await fetchMoviesInBackground()
        }.task {
            let userDefaultMovies = Movie.getDataFromUserDefaults()
            if userDefaultMovies.isEmpty {
                /// If we can't find any data in userdefaults, fetch from backend
                do {
                    movies = try await Movie.fetchDataFromBackend()
                    Movie.saveDataToUserDefaults(movies)
                    isLoading = false
                } catch {
                    self.error = error
                    isLoading = false
                }
            } else {
                /// If we do find data in userdefaults, present said data and then fetch data
                /// from backend in backgound to update values
                movies = userDefaultMovies
                isLoading = false
                await fetchMoviesInBackground()
            }
            isLoading = false
        }.navigationTitle("StartView.MoviesButton.Title")
    }
    
    func fetchMoviesInBackground() async {
        /// If cached data is too old (in this case 1 day): replace with new data
        var invalidateCache = false
        if let cacheTimeStamp = User.getCacheTimeStamp() {
            let timeDifference = Calendar.current.dateComponents([.day], from: cacheTimeStamp, to: Date()).day ?? 0
            invalidateCache = timeDifference > 1
        }
        
        do {
            let newMovies = try await Movie.fetchDataFromBackend()
            /// If there is any new/updated data in backend compared to our current data, update.
            if invalidateCache || movies != newMovies {
                movies = newMovies
                Movie.saveDataToUserDefaults(movies)
            }
        } catch {
            /// In this case i chose to fail silently here. But one could certainly go for a more verbal approach and tell the user the fetching failed
        }
    }
}

#Preview {
    MovieListView()
}
