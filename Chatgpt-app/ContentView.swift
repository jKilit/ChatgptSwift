import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = MovieViewModel()
    
    var body: some View {
        TabView {
            HomeScreen(viewModel: viewModel)
                .tabItem {
                    Text("Home")
                }
            WatchlistView(viewModel: viewModel)
                .tabItem {
                    Text("Watchlist")
                }
        }
        .onAppear {
            viewModel.fetchTrendingMovies()
            // Fetch other initial data here if needed
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
