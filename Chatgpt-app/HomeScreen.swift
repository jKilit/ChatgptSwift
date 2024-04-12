import SwiftUI

struct HomeScreen: View {
    @ObservedObject var viewModel: MovieViewModel
    @State private var selectedMovie: Movie? = nil
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Trending Movies")
                    .font(.title)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(viewModel.trendingMovies) { movie in
                            Button(action: {
                                selectedMovie = movie
                            }) {
                                MovieCard(movie: movie)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .sheet(item: $selectedMovie) { movie in
                                MovieDetailsView(movie: movie)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                Text("Popular Movies")
                    .font(.title)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(viewModel.popularMovies) { movie in
                            Button(action: {
                                selectedMovie = movie
                            }) {
                                MovieCard(movie: movie)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .sheet(item: $selectedMovie) { movie in
                                MovieDetailsView(movie: movie)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Other UI elements can be added here
            }
        }
        .onAppear {
            viewModel.fetchTrendingMovies()
            viewModel.fetchPopularMovies()
            // Fetch other initial data here if needed
        }
    }
}
