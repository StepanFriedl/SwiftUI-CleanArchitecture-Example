//
//  FavoritesRepository.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 22.10.2024.
//

import CoreData
import SwiftUI

protocol FavoritesRepositoryProtocol {
    func fetchFavoriteMovies() throws -> [Movie]
    func saveFavoriteMovie(_ movie: Movie) throws
    func removeFavoriteMovie(_ movieID: Int) throws
    func isFavoriteMovie(_ movieID: Int) throws -> Bool
}

class FavoritesRepository: FavoritesRepositoryProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchFavoriteMovies() throws -> [Movie] {
        let fetchRequest: NSFetchRequest<FavoriteMoviesEntity> = FavoriteMoviesEntity.fetchRequest()
        let favoriteMoviesEntities = try context.fetch(fetchRequest)
        return favoriteMoviesEntities.map { $0.toMovie() }
    }

    func saveFavoriteMovie(_ movie: Movie) throws {
        let fetchRequest: NSFetchRequest<FavoriteMoviesEntity> = FavoriteMoviesEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id)

        let results = try context.fetch(fetchRequest)
        if results.isEmpty {
            let favoriteMovieEntity = movie.toEntity(entityType: FavoriteMoviesEntity.self, context: context)
            context.insert(favoriteMovieEntity)
            try context.save()
        }
    }

    func removeFavoriteMovie(_ movieID: Int) throws {
        let fetchRequest: NSFetchRequest<FavoriteMoviesEntity> = FavoriteMoviesEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieID)

        let results = try context.fetch(fetchRequest)
        if let movieEntityToRemove = results.first {
            context.delete(movieEntityToRemove)
            try context.save()
        }
    }

    func isFavoriteMovie(_ movieID: Int) throws -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteMoviesEntity> = FavoriteMoviesEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieID)

        let results = try context.fetch(fetchRequest)
        return !results.isEmpty
    }
}
