//
//  PostsView.swift
//  SmartRSS
//
//  Created by Seyyed Parsa Neshaei on 9/2/21.
//

import SwiftUI
import FeedKit

struct PostsView: View {
    var selectedSource: Source
    
    @State var hasLoadingErrorHappened = false
    @State var posts: [Post] = []
    
    func populateAtomPosts(from feed: Feed) {
        guard let items = feed.atomFeed?.entries else {
            hasLoadingErrorHappened = true
            return
        }
        posts = items.map { item in
            let post = Post()
            post.title = item.title ?? "Unknown"
            post.publishedDate = item.published ?? Date()
            if let content = item.content, let contentEncoded = content.value {
                post.content = contentEncoded
            }
            return post
        }
    }
    
    func populatePosts(from feed: Feed) {
        guard let items = feed.rssFeed?.items else {
            populateAtomPosts(from: feed)
            return
        }
        posts = items.map { item in
            let post = Post()
            post.title = item.title ?? "Unknown"
            post.publishedDate = item.pubDate ?? Date()
            if let content = item.content, let contentEncoded = content.contentEncoded {
                post.content = contentEncoded
            }
            return post
        }
    }
    
    func loadPosts() async {
        guard let sourceURL = selectedSource.sourceURL else { return }
        do {
            let stringData = try await loadData(from: sourceURL)
            let result = FeedParser(data: stringData.data(using: .utf8) ?? Data()).parse()
            switch result {
            case .success(let feed):
                main { populatePosts(from: feed) }
            case .failure(let error):
                print(error.localizedDescription)
                main { hasLoadingErrorHappened = true }
            }
        } catch {
            main { hasLoadingErrorHappened = true }
        }
    }
    
    var body: some View {
        List {
            ForEach(0..<posts.count, id: \.self) { id in
                NavigationLink(destination: PostView(selectedPost: posts[id])) {
                    Text(posts[id].title)
                }
            }
        }
        .alert("An error has occurred while loading the posts. Please try again", isPresented: $hasLoadingErrorHappened) {
            Button("OK", role: .cancel) { }
        }
        .navigationBarTitle(Text(selectedSource.title ?? "Unknown"))
        .task(loadPosts)
        .environment(\.defaultMinListRowHeight, 50)
    }
}

//struct PostsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostsView()
//    }
//}
