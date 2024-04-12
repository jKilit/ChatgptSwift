import Foundation
import Combine

class MovieViewModel: ObservableObject {
    @Published var trendingMovies = [Movie]()
    @Published var popularMovies = [Movie]()
    @Published var searchResults = [Movie]()
    
    func fetchTrendingMovies() {
        // Fetch trending movies from API
        let API_KEY = "b6aa980ddd20798802c7cc95ed96a3ac"
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(API_KEY)")!)
            .map { $0.data }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: &$trendingMovies)
    }
    
    func fetchPopularMovies() {
        // Fetch popular movies from API
        let API_KEY = "b6aa980ddd20798802c7cc95ed96a3ac"
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(API_KEY)")!)
            .map { $0.data }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: &$popularMovies)
    }
    
    func fetchMovieCredits(movieID: Int) {
        print(movieID)
        // Fetch movie credits from API
        let API_KEY = "b6aa980ddd20798802c7cc95ed96a3ac"
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\(API_KEY)&language=en-US")!)
            .map { $0.data }
            .decode(type: CreditsResponse.self, decoder: JSONDecoder())
            .map { $0.cast }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching movie credits: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { cast in
                print(cast)
                // Handle received cast data
            })
    }


}
