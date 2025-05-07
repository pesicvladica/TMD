//
//  Media+IsFullModel.swift
//  TMDApplication
//
//  Created by Vladica Pesic on 7.5.25..
//

import TheMovieDatabase

extension Media {
    func isFullModel() -> Bool {
        subtitle1 != nil && subtitle2 != nil
    }
}
