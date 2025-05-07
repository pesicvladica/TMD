//
//  TMDApplicationApp.swift
//  TMDApplication
//
//  Created by Vladica Pesic on 7.5.25..
//

import SwiftUI

@main
struct TMDApplicationApp: App {
    var body: some Scene {
        WindowGroup {
            MediaListModule.makeModule(router: MediaListRouter())
        }
    }
}
