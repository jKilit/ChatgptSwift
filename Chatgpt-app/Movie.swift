struct MovieResponse: Codable {
    let results: [Movie]
}

struct CreditsResponse: Codable {
    let cast: [CastMember]
}

struct Movie: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let overview: String
    let backdrop_path: String?
    let poster_path: String?
    let vote_average: Float?
    // Add more properties as needed
}


struct CastMember: Identifiable, Codable {
    let id: Int
    let name: String
    let profile_path: String?
    // Add more properties as needed
}
