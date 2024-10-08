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
    
    func fetchTopRatedMovies() async throws -> [Movie] {
        let urlString = "\(Urls.serverURL)\(Urls.topRated)?api_key=\(apiKey)"
        print("Going to make the request: \(urlString)")
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        try saveMoviesToCoreData(decodedResponse.results)
        return decodedResponse.results
    }
    
    func fetchTopRatedMoviesFromCoreData() throws -> [Movie] {
        print("Going to fetch from the CoreData")
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let movieEntitites = try context.fetch(fetchRequest)
        return movieEntitites.map { $0.toMovie() }
    }
    
    private func saveMoviesToCoreData(_ movies: [Movie]) throws {
        try clearMoviesFromCoreData()
        for movie in movies {
            let movieEntity = movie.toMovieEntity(context: context)
            context.insert(movieEntity)
        }
        try context.save()
    }
    
    private func clearMoviesFromCoreData() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = MovieEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}
