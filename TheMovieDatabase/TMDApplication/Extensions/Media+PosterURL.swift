//
//  Media+PosterURL.swift
//  TMDApplication
//
//  Created by Vladica Pesic on 7.5.25..
//

import Foundation
import TheMovieDatabase

extension Media {
    func posterURL() -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/original/\(poster)")
    }
}
