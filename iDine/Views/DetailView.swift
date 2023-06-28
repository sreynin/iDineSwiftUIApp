//
//  DetailView.swift
//  iDine
//
//  Created by Sreynin on 2023/06/28.
//

import SwiftUI

struct DetailView: View {
    
   var item : MenuItem? = nil

    var body: some View {
        NavigationStack{
            
            VStack{

                ZStack(alignment: .bottomTrailing){
                 
                    Image(item?.mainImage ?? "" )
                        .resizable()
                        .scaledToFit()
                    Text("Photo: \(item?.photoCredit ?? "")")
                        .padding(4)
                        .background(.black)
                        .font(.caption)
                        .foregroundColor(.white)
                        .offset(x: -5, y: -5)
                }
                Text(item?.description ?? "")
                Spacer()
                
            }
            .navigationTitle("Detail Menu")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            DetailView()
        }
        
    }
}
