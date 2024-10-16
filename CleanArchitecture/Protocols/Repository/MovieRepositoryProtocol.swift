//
//  MovieRepositoryProtocol.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 27.09.2024.
//

import Foundation

protocol MovieRepositoryProtocol {
    func fetchTopRatedMovies() async throws -> [Movie]
    func fetchTopRatedMoviesFromCoreData() throws -> [Movie]
    func fetchOnTheAirMovies() async throws -> [Movie]
    func fetchOnTheAirMoviesFromCoreData() throws -> [Movie]
    func getFavoriteMovieIDs() -> Set<Int>
    func saveFavoriteMovieID(_ movieID: Int)
    func removeFavoriteMovieID(_ movieID: Int)
}
