import SwiftUI

struct HomeScreen: View {
    @ObservedObject var viewModel: MovieViewModel
    @State private var selectedMovie: Movie? = nil
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search for movies")
            
            ScrollView {
                if !viewModel.searchResults.isEmpty {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.searchResults) { movie in
                            MovieRow(movie: movie, isLiked: viewModel.isMovieLiked(movie)) {
                                viewModel.toggleLike(movie) // Closure to add/remove movie from liked movies
                            }
                                .onTapGesture {
                                    selectedMovie = movie
                                }
                                .contextMenu {
                                    Button(action: {
                                        viewModel.toggleLike(movie)
                                    }) {
                                        Text(viewModel.isMovieLiked(movie) ? "Unlike" : "Like")
                                        Image(systemName: viewModel.isMovieLiked(movie) ? "heart.fill" : "heart")
                                    }
                                }
                                .sheet(item: $selectedMovie) { movie in
                                    MovieDetailsView(movie: movie, viewModel: viewModel)
                                }
                        }
                    }
                    .padding()
                } else {
                    VStack(alignment: .leading) {
                        Text("Trending Movies")
                            .font(.title)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(viewModel.trendingMovies) { movie in
                                    MovieRow(movie: movie, isLiked: viewModel.isMovieLiked(movie)) {
                                        viewModel.toggleLike(movie) // Closure to add/remove movie from liked movies
                                    }
                                        .onTapGesture {
                                            selectedMovie = movie
                                        }
                                        .contextMenu {
                                            Button(action: {
                                                viewModel.toggleLike(movie)
                                            }) {
                                                Text(viewModel.isMovieLiked(movie) ? "Unlike" : "Like")
                                                Image(systemName: viewModel.isMovieLiked(movie) ? "heart.fill" : "heart")
                                            }
                                        }
                                        .sheet(item: $selectedMovie) { movie in
                                            MovieDetailsView(movie: movie, viewModel: viewModel)
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
                                    MovieRow(movie: movie, isLiked: viewModel.isMovieLiked(movie)) {
                                        viewModel.toggleLike(movie) // Closure to add/remove movie from liked movies
                                    }
                                        .onTapGesture {
                                            selectedMovie = movie
                                        }
                                        .contextMenu {
                                            Button(action: {
                                                viewModel.toggleLike(movie)
                                            }) {
                                                Text(viewModel.isMovieLiked(movie) ? "Unlike" : "Like")
                                                Image(systemName: viewModel.isMovieLiked(movie) ? "heart.fill" : "heart")
                                            }
                                        }
                                        .sheet(item: $selectedMovie) { movie in
                                            MovieDetailsView(movie: movie, viewModel: viewModel)
                                        }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                viewModel.fetchTrendingMovies()
                viewModel.fetchPopularMovies()
                // Fetch other initial data here if needed
            }
        }
        .padding(.top)
        .onChange(of: searchText) { newValue in
            viewModel.searchMovies(query: newValue)
        }
    }
}
