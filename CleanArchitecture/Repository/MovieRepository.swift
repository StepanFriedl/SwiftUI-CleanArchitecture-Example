//
//  MovieRepository.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import CoreData
import Foundation

class MovieRepository: MovieRepositoryProtocol {
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchOnTheAirMovies() async throws -> [Movie] {
        let urlString = "\(Urls.serverURL)\(Urls.onTheAir)?api_key=\(apiKey)"
        print("Going to make the request: \(urlString)")
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodedResponse = try JSONDecoder().decode(OnTheAirMoviesResponse.self, from: data)
        let results = decodedResponse.results
        try saveOnTheAirMoviesToCoreData(results)
        return results
    }
    
    func fetchTopRatedMovies() async throws -> [Movie] {
        let urlString = "\(Urls.serverURL)\(Urls.topRated)?api_key=\(apiKey)"
        print("Going to make the request: \(urlString)")
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        try saveTopRatedMoviesToCoreData(decodedResponse.results)
        return decodedResponse.results
    }
    
    func fetchOnTheAirMoviesFromCoreData() throws -> [Movie] {
        print("Going to fetch on the air movies from the CoreData")
        let fetchRequest: NSFetchRequest<OnTheAirMoviesEntity> = OnTheAirMoviesEntity.fetchRequest()
        let moviesEntity = try context.fetch(fetchRequest)
        return moviesEntity.map { $0.toMovie() }
    }
    
    func fetchTopRatedMoviesFromCoreData() throws -> [Movie] {
        print("Going to fetch top rated movies from the CoreData")
        let fetchRequest: NSFetchRequest<TopRatedMoviesEntity> = TopRatedMoviesEntity.fetchRequest()
        let movieEntitites = try context.fetch(fetchRequest)
        return movieEntitites.map { $0.toMovie() }
    }
    
    private func saveOnTheAirMoviesToCoreData(_ movies: [Movie]) throws {
        try clearOnTheAirMoviesFromCoreData()
        for movie in movies {
            let movieEntity = movie.toOnTheAirMovieEntity(context: context)
            context.insert(movieEntity)
        }
        try context.save()
    }
    
    private func clearOnTheAirMoviesFromCoreData() throws {
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
}

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct OnTheAirMoviesResponse: Decodable {
    let page: Int
    let results: [Movie]
}
