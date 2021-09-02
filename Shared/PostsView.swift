//
//  PostsView.swift
//  SmartRSS
//
//  Created by Seyyed Parsa Neshaei on 9/2/21.
//

import SwiftUI

struct PostsView: View {
    var selectedSource: Source
    
    var body: some View {
        List {
            NavigationLink(destination: PostView(selectedPost: Post())) {
                Text("iii")
            }
        }
        .navigationBarTitle(Text(selectedSource.title ?? "Unknown"))
        .task {
            guard let sourceURL = selectedSource.sourceURL else { return }
            do {
                let stringData = try await loadData(from: sourceURL)
            } catch {
                
            }
        }
    }
}

//struct PostsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostsView()
//    }
//}
