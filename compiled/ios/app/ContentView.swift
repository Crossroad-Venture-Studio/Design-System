//
//  ContentView.swift
//  app
//
//  Created by William Brendel on 11/29/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Webview, ignoring notch safe area
        // It will be dealt inside the html
        WebView().edgesIgnoringSafeArea(.all)
    }
}

// For debugging purpose
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
