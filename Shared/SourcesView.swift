//
//  SourcesView.swift
//  SmartRSS
//
//  Created by Seyyed Parsa Neshaei on 9/2/21.
//

import SwiftUI

struct SourcesView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Source.entity(), sortDescriptors: []) var sources: FetchedResults<Source>
    
    @Binding var selectedSource: Source?
    
    @State private var isLinkToAddSourceViewActive = false
    @State var hasCoreDataErrorOccurred = false
    
    func removeLanguages(at offsets: IndexSet) {
        for index in offsets {
            let source = sources[index]
            managedObjectContext.delete(source)
        }
        do {
            try managedObjectContext.save()
        } catch {
            hasCoreDataErrorOccurred = true
        }
    }
    
    var body: some View {
        List {
            ForEach(sources, id: \.self) { source in
                NavigationLink(destination: PostsView(selectedSource: source)) {
                    Text(source.title ?? "Unknown")
                }
            }
            .onDelete(perform: removeLanguages)
        }
        .alert("An error has occurred while saving the new source. Please try again", isPresented: $hasCoreDataErrorOccurred) {
            Button("OK", role: .cancel) { }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Sources")
        .toolbar {
            Button {
                isLinkToAddSourceViewActive = true
            } label: {
                NavigationLink(destination: AddSourceView().environment(\.managedObjectContext, managedObjectContext), isActive: $isLinkToAddSourceViewActive) {
                    Image(systemName: "plus")
                }
            }
            EditButton()
        }
    }
}

struct SourcesView_Previews: PreviewProvider {
    static var previews: some View {
        SourcesView(selectedSource: .constant(nil))
    }
}
