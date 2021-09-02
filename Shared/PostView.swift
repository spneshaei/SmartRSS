//
//  PostView.swift
//  SmartRSS
//
//  Created by Seyyed Parsa Neshaei on 9/2/21.
//

import SwiftUI

struct PostView: View {
    @State var selectedPost: Post
    
    func parseHTML() {
        
    }
    
    var body: some View {
//        WebView(text: $selectedPost.content)
//          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        Text("Hi")
            .onAppear(perform: parseHTML)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(selectedPost: Post())
    }
}
