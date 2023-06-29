//
//  TableDetailView.swift
//  iDine
//
//  Created by Sreynin on 2023/06/29.
//

import SwiftUI

struct TabDetailView: View {
    @State var selectedView = 1
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedView) {
                ContentView()
                    .padding()
                    .tabItem {
                        Label("First",systemImage: "1.circle")
                    }
                    .tag(1)
                
                Text("Second View")
                    .padding()
                    .tabItem {
                        Label("Second", systemImage: "2.circle")
                    }
                    .tag(2)
                
            }
            .navigationTitle("Tab")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TabDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TabDetailView()
    }
}
