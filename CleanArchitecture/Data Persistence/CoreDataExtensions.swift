//
//  CoreDataExtensions.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 01.10.2024.
//

import Foundation
import CoreData

extension Movie {
    func toTopRatedMovieEntity(context: NSManagedObjectContext) -> TopRatedMoviesEntity {
        let movieEntity = TopRatedMoviesEntity(context: context)
        movieEntity.id = Int64(self.id)
        movieEntity.title = self.title
        movieEntity.overview = self.overview
        movieEntity.posterPath = self.posterPath
        movieEntity.releaseDate = self.releaseDate
        movieEntity.voteAverage = self.voteAverage
        return movieEntity
    }
    
    func toOnTheAirMovieEntity(context: NSManagedObjectContext) -> OnTheAirMoviesEntity {
        let movieEntity = OnTheAirMoviesEntity(context: context)
        movieEntity.id = Int64(self.id)
        movieEntity.title = self.title
        movieEntity.overview = self.overview
        movieEntity.posterPath = self.posterPath
        movieEntity.releaseDate = self.releaseDate
        movieEntity.voteAverage = self.voteAverage
        return movieEntity
    }
}

extension OnTheAirMoviesEntity {
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

extension TopRatedMoviesEntity {
    func toMovie() -> Movie {
        return Movie(
            id: Int(self.id),
            title: self.title ?? "",
            overview: self.overview ?? "",
            posterPath: self.posterPath,
            releaseDate: self.releaseDate ?? "",
            voteAverage: self.voteAverage
        )
    }
}
