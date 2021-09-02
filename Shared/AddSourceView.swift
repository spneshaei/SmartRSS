//
//  AddSourceView.swift
//  SmartRSS
//
//  Created by Seyyed Parsa Neshaei on 9/2/21.
//

import SwiftUI

struct AddSourceView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var websiteTitle = ""
    @State var websiteURL = ""
    @State var hasCoreDataErrorOccurred = false
    
    func addSource() {
        let source = Source(context: managedObjectContext)
        source.title = websiteTitle
        source.sourceURL = websiteURL
        do {
            try managedObjectContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch(let error) {
            print(error.localizedDescription)
            hasCoreDataErrorOccurred = true
        }
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $websiteTitle)
            TextField("URL", text: $websiteURL)
                .autocapitalization(.none)
        }
        .alert("An error has occurred while saving the new source. Please try again", isPresented: $hasCoreDataErrorOccurred) {
            Button("OK", role: .cancel) { }
        }
        .navigationTitle("Add Source")
        .toolbar {
            Button("Done", action: addSource)
        }
    }
}

struct AddSourceView_Previews: PreviewProvider {
    static var previews: some View {
        AddSourceView()
    }
}
