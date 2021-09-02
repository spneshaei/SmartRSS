//
//  PostView.swift
//  SmartRSS
//
//  Created by Seyyed Parsa Neshaei on 9/2/21.
//

import SwiftUI

struct PostView: View {
    var selectedPost: Post
    
    var body: some View {
        Text("\(selectedPost.title) View")
    }
}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}
