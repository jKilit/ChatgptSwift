import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    
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
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(movie.title)
                        .font(.title)
                    Text("Overview:")
                        .font(.headline)
                    Text(movie.overview)
                }
                .padding(.horizontal)
                
                // Other movie details like actors, rating, runtime can be added here
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle(movie.title)
    }
}
