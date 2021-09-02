//
//  SmartRSSApp.swift
//  Shared
//
//  Created by Seyyed Parsa Neshaei on 9/2/21.
//

import SwiftUI

@main
struct SmartRSSApp: App {
    let persistenceController = PersistenceController.shared
    
    @State var selectedSource: Source? = nil
    @State var selectedPost: Post? = nil

    var body: some Scene {
        WindowGroup {
            NavigationView {
                SourcesView(selectedSource: $selectedSource)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
                if let selectedSource = selectedSource {
                    PostsView(selectedSource: selectedSource)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                } else {
                    Text("Select a source to view its posts")
                }
                
                if let selectedPost = selectedPost {
                    PostView(selectedPost: selectedPost)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                } else {
                    Text("Select a post to view its contents")
                }
            }
        }
    }
}
