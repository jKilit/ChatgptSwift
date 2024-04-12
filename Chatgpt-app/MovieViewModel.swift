import Foundation
import Combine

class MovieViewModel: ObservableObject {
    @Published var trendingMovies = [Movie]()
    @Published var popularMovies = [Movie]()
    @Published var searchResults = [Movie]()
    @Published var likedMovies = [Movie]()
    
    private let API_KEY = "b6aa980ddd20798802c7cc95ed96a3ac"
    private var cancellables = Set<AnyCancellable>()
    
    func fetchTrendingMovies() {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(API_KEY)")!)
            .map { $0.data }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: &$trendingMovies)
    }
    
    func fetchPopularMovies() {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(API_KEY)")!)
            .map { $0.data }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: &$popularMovies)
    }
    
    func searchMovies(query: String) {
        guard !query.isEmpty else {
            searchResults.removeAll()
            return
        }
        
        let url = "https://api.themoviedb.org/3/search/movie?api_key=\(API_KEY)&language=en-US&page=1&include_adult=false&query=\(query)"
        
        URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .map { $0.data }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] movies in
                self?.searchResults = movies
            })
            .store(in: &cancellables)
    }
    
    func isMovieLiked(_ movie: Movie) -> Bool {
        return likedMovies.contains(movie)
    }
    
    func toggleLike(_ movie: Movie) {
        if let index = likedMovies.firstIndex(of: movie) {
            likedMovies.remove(at: index)
        } else {
            likedMovies.append(movie)
        }
    }
}
