import SwiftUI

struct WatchlistView: View {
    @ObservedObject var viewModel: MovieViewModel
    @State private var selectedMovie: Movie? = nil // State variable to track the selected movie
    
    var body: some View {
        VStack {
            Text("Watchlist")
                .font(.title)
                .padding()
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.likedMovies) { movie in
                        // Navigation on tap to movie details view
                        Button(action: {
                            selectedMovie = movie
                        }) {
                            MovieRow(movie: movie, isLiked: true) {
                                viewModel.toggleLike(movie)
                            }
                            .padding(.horizontal)
                        }
                        .sheet(item: $selectedMovie) { movie in
                            MovieDetailsView(movie: movie, viewModel: viewModel)
                        }
                    }
                }
            }
        }
    }
}
