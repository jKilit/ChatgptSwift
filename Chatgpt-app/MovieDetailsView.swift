import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    @ObservedObject var viewModel: MovieViewModel // Add viewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let backdropPath = movie.backdrop_path {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure:
                            Image(systemName: "exclamationmark.icloud")
                                .foregroundColor(.red)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(height: 200)
                    .cornerRadius(10)
                }
                
                HStack {
                    Text(movie.title)
                        .font(.title)
                    Spacer()
                    Button(action: {
                        viewModel.toggleLike(movie)
                    }) {
                        Image(systemName: viewModel.isMovieLiked(movie) ? "heart.fill" : "heart")
                            .foregroundColor(viewModel.isMovieLiked(movie) ? .red : .gray)
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Overview:")
                        .font(.headline)
                    Text(movie.overview)
                }
                .padding(.horizontal)
                
                // Display cast members
                Text("Cast:")
                    .font(.headline)
                    .padding(.top)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(viewModel.castMembers) { castMember in
                            CastMemberView(castMember: castMember)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Other movie details like rating, runtime can be added here
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle(movie.title)
        .onAppear {
            // Fetch movie credits
            viewModel.fetchMovieCredits(for: movie.id)
        }
    }
}

struct CastMemberView: View {
    let castMember: CastMember
    
    var body: some View {
        VStack {
            if let profilePath = castMember.profile_path {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(profilePath)")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 150)
                            .cornerRadius(8)
                    case .failure:
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 150)
                            .cornerRadius(8)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 100, height: 150)
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150)
                    .cornerRadius(8)
                    .foregroundColor(.gray)
            }
            Text(castMember.name)
                .font(.caption)
                .lineLimit(1)
                .frame(width: 100)
                .padding(.top, 5)
        }
    }
}
