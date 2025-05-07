//
//  MediaListView.swift
//  TMDApplication
//
//  Created by Vladica Pesic on 7.5.25..
//

import SwiftUI
import TheMovieDatabase

struct MediaListView<Router: MediaListRouterProtocol>: View {
    @ObservedObject var presenter: MediaListPresenter
    private let router: Router
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(presenter: MediaListPresenter, router: Router) {
        self.presenter = presenter
        self.router = router
    }

    var body: some View {
        VStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(presenter.genres) { genre in
                        Text(genre.name)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                presenter.selectedGenre == genre ? Color.gray.opacity(0.3) : Color.white
                            )
                            .clipShape(Capsule())
                            .onTapGesture {
                                presenter.select(genre: genre)
                            }
                    }
                }.padding()
            }
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(presenter.mediaItems) { item in
                        MediaGridItem(media: item)
                            .onAppear {
                                if presenter.shouldLoadMore(currentItem: item) {
                                    presenter.loadMore()
                                }
                            }
                    }
                }
                .padding(.horizontal)
            }
            .refreshable {
                presenter.refresh()
            }
            
            HStack {
                Spacer()
                Button(action: { presenter.select(mediaType: .movie) }) {
                    VStack {
                        Image(systemName: "film")
                        Text("Movie")
                    }
                    .tint(presenter.selectedMediaType == .movie ? .blue : .gray)
                }
                Spacer()
                Button(action: { presenter.select(mediaType: .tv) }) {
                    VStack {
                        Image(systemName: "tv")
                        Text("TV")
                    }
                    .tint(presenter.selectedMediaType == .tv ? .blue : .gray)
                }
                Spacer()
            }
            .padding(.vertical, 8)
            
        }
        .navigationTitle(presenter.selectedMediaType == .movie ? "Movies" : "Shows")
    }
}


