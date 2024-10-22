//
//  MovieRepository.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import CoreData
import SwiftUI

protocol MovieRepositoryProtocol {
    func fetchTopRatedMovies() async throws -> [Movie]
    func fetchTopRatedMoviesFromCoreData() throws -> [Movie]
    func fetchOnTheAirMovies() async throws -> [Movie]
    func fetchOnTheAirMoviesFromCoreData() throws -> [Movie]
    func getFavoriteMovieIDs() -> Set<Int>
    func saveFavoriteMovieID(_ movieID: Int)
    func removeFavoriteMovieID(_ movieID: Int)
    func resetNextPageToLoadOnTheAirMovies()
    func clearOnTheAirMoviesFromCoreData() throws
}

class MovieRepository: MovieRepositoryProtocol {
    @AppStorage("nextOnTheAirPageToLoad") var nextOnTheAirPageToLoad: Int = 1
    @AppStorage("totalOnTheAirPages") var totalOnTheAirPages: Int = 999
    
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchOnTheAirMovies() async throws -> [Movie] {
        print("Going to fetch on the air movies.")
        guard nextOnTheAirPageToLoad <= totalOnTheAirPages else {
            return []
        }
        let urlString = "\(Urls.serverURL)\(Urls.onTheAir)?api_key=\(apiKey)&page=\(nextOnTheAirPageToLoad)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(OnTheAirMoviesResponse.self, from: data)
        let results = decodedResponse.results
        guard !results.isEmpty else {
            throw NSError(domain: "NoMoviesError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No movies found"])
        }
        try saveOnTheAirMoviesToCoreData(results)
        totalOnTheAirPages = decodedResponse.totalPages
        nextOnTheAirPageToLoad += 1
        return results
    }
    
    func fetchTopRatedMovies() async throws -> [Movie] {
        print("Going to fetch top rated movies.")
        let urlString = "\(Urls.serverURL)\(Urls.topRated)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        try saveTopRatedMoviesToCoreData(decodedResponse.results)
        return decodedResponse.results
    }
    
    func fetchOnTheAirMoviesFromCoreData() throws -> [Movie] {
        print("Going to fetch CoreData’s on the air movies.")
        let fetchRequest: NSFetchRequest<OnTheAirMoviesEntity> = OnTheAirMoviesEntity.fetchRequest()
        let moviesEntity = try context.fetch(fetchRequest)
        return moviesEntity.map { $0.toMovie() }
    }
    
    func fetchTopRatedMoviesFromCoreData() throws -> [Movie] {
        print("Going to fetch CoreData’s top rated movies.")
        let fetchRequest: NSFetchRequest<TopRatedMoviesEntity> = TopRatedMoviesEntity.fetchRequest()
        let movieEntitites = try context.fetch(fetchRequest)
        return movieEntitites.map { $0.toMovie() }
    }
    
    private func saveOnTheAirMoviesToCoreData(_ movies: [Movie]) throws {
        // try clearOnTheAirMoviesFromCoreData()
        for movie in movies {
            let movieEntity = movie.toOnTheAirMovieEntity(context: context)
            context.insert(movieEntity)
        }
        try context.save()
    }
    
    func clearOnTheAirMoviesFromCoreData() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = OnTheAirMoviesEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)
    }
    
    private func saveTopRatedMoviesToCoreData(_ movies: [Movie]) throws {
        try clearTopRatedMoviesFromCoreData()
        for movie in movies {
            let movieEntity = movie.toTopRatedMovieEntity(context: context)
            context.insert(movieEntity)
        }
        try context.save()
    }
    
    private func clearTopRatedMoviesFromCoreData() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = TopRatedMoviesEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)
    }
    
    func getFavoriteMovieIDs() -> Set<Int> {
        guard let savedFavoriteIDs = UserDefaults.standard.array(forKey: UserDefaultsKeys.favorites) as? [Int] else { return [] }
        return Set(savedFavoriteIDs)
    }
    
    func saveFavoriteMovieID(_ movieID: Int) {
        var favorites = self.getFavoriteMovieIDs()
        favorites.insert(movieID)
        
        UserDefaults.standard.set(Array(favorites), forKey: UserDefaultsKeys.favorites)
    }
    
    func removeFavoriteMovieID(_ movieID: Int) {
        var favorites = self.getFavoriteMovieIDs()
        favorites.remove(movieID)
        
        UserDefaults.standard.set(Array(favorites), forKey: UserDefaultsKeys.favorites)
    }
    
    func resetNextPageToLoadOnTheAirMovies() {
        self.nextOnTheAirPageToLoad = 1
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct OnTheAirMoviesResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}
