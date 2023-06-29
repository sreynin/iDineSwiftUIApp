//
//  ContentView.swift
//  iDine
//
//  Created by Sreynin on 2023/06/27.
//

import SwiftUI

struct ContentView: View {
    
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    @State var isPresent :Bool = false
    var body: some View {
        VStack {
            /*Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")*/
            NavigationStack{
                List{
                    ForEach(menu) { section in
                        Section(section.name){
                            ForEach(section.items) { item in
                                NavigationLink(destination: DetailView(item: item)) {
                                    Text(item.name)
                                   }
                                   
                            }

                        }
                    
                    }
                }
                .navigationTitle("Menu")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Back"){
                            print("Hello")
                            isPresent.toggle()
                        }
                    }
                }
                .listStyle(.grouped)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ContentView()
        }
    }
}
