//
//  MediaGridItem.swift
//  TMDApplication
//
//  Created by Vladica Pesic on 7.5.25..
//

import SwiftUI
import SDWebImageSwiftUI
import TheMovieDatabase

struct MediaGridItem: View {
    let media: Media

    var body: some View {
        VStack {
            WebImage(url: media.posterURL()) { image in
                image.resizable()
            } placeholder: {
                Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity)
            .scaledToFit()
            .frame(height: 100)
            
            Text("Title: \(media.title)")
                .lineLimit(1)
            Text("Rating: \(media.rating, specifier: "%.1f")")
            if media.mediaType == .movie {
                if let budget = Int(media.subtitle1 ?? "0") {
                    Text("Budget: \(budget/1000000) M")
                }
                if let revenue = Int(media.subtitle2 ?? "0") {
                    Text("Revenue: \(revenue/1000000) M")
                }
            }
            else {
                if let lastAirDate = media.subtitle1 {
                    Text("Last air date: \(lastAirDate)")
                }
                if let lastEpisodeName = media.subtitle2 {
                    Text("Last episode name: \(lastEpisodeName)")
                }
            }
        }
    }
}
