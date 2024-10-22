//
//  CoreDataExtensions.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 01.10.2024.
//

import Foundation
import CoreData

protocol MovieEntityProtocol {
    var id: Int64 { get set }
    var title: String? { get set }
    var overview: String? { get set }
    var posterPath: String? { get set }
    var releaseDate: String? { get set }
    var voteAverage: Double { get set }
    
    func toMovie() -> Movie
}

extension MovieEntityProtocol {
    func toMovie() -> Movie {
        return Movie(
            id: Int(self.id),
            title: self.title ?? "",
            overview: self.overview ?? "",
            posterPath: self.posterPath ?? "",
            releaseDate: self.releaseDate ?? "",
            voteAverage: self.voteAverage
        )
    }
}

extension Movie {
    func toEntity<T: NSManagedObject & MovieEntityProtocol>(entityType: T.Type, context: NSManagedObjectContext) -> T {
        var entity = T(context: context)
        entity.id = Int64(self.id)
        entity.title = self.title
        entity.overview = self.overview
        entity.posterPath = self.posterPath
        entity.releaseDate = self.releaseDate
        entity.voteAverage = self.voteAverage
        return entity
    }
}

extension TopRatedMoviesEntity: MovieEntityProtocol {}
extension OnTheAirMoviesEntity: MovieEntityProtocol {}
extension FavoriteMoviesEntity: MovieEntityProtocol {}
