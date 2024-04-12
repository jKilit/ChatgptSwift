import SwiftUI

struct MovieRow: View {
    let movie: Movie
    let isLiked: Bool
    let addToLikedMovies: () -> Void // Add a closure to add the movie to liked movies

    var body: some View {
        HStack {
            if let posterPath = movie.poster_path {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)")) { phase in
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
                        Image(systemName: "photo")
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
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150)
                    .cornerRadius(8)
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(movie.title)
                        .font(.headline)
                        .lineLimit(2)
                        .frame(width: 200) // Adjusting the width of the description
                    Button(action: {
                        addToLikedMovies()
                    }) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(isLiked ? .red : .gray)
                    }
                }
                HStack {
                    Text("Rating: \(String(format: "%.1f", movie.vote_average ?? 0.0))") // Displaying the movie rating
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                }
                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(3)
            }
            .padding(.leading, 8)
            
            Spacer()
        }
        .padding(.vertical, 8)
        .frame(width: 350)
    }
}
