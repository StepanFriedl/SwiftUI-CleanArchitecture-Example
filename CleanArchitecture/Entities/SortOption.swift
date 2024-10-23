//
//  SortOption.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 23.10.2024.
//

import Foundation

enum SortOption: String, CaseIterable {
    case defaultOption = "Default"
    case nameAsc = "Name ↑"
    case nameDesc = "Name ↓"
    case releaseYearAsc = "Release Year ↑"
    case releaseYearDesc = "Release Year ↓"
    case ratingAsc = "Rating ↑"
    case ratingDesc = "Rating ↓"
}
