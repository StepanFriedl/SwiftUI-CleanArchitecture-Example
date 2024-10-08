//
//  URLHelpers.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 04.10.2024.
//

import Foundation

func createImageUrl(path: String?) -> URL? {
    guard let path = path else { return nil }
    return URL(string: "\(Urls.imagesURL)\(path)")
}
