//
//  ContentView.swift
//  iDine
//
//  Created by Sreynin on 2023/06/27.
//

import SwiftUI
import ActivityKit


struct ContentView: View {
    
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    @State var activities = Activity<MyWidgetAttributes>.activities
    @State var isPresent :Bool = false
    @State var showAlert: Bool = false
    @State var alertMsg: String = ""
    
    
    var body: some View {
        VStack {
            /*Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")*/
            NavigationStack{
                //LiveActivity
                List{
                    Button {
                        startLiveActivity()
                    } label: {
                        Text("Start LiveActivity")
                            .foregroundColor(.blue)
                    }
                    
                    Button {
                        endAllActivity()
                    } label: {
                        Text("End LiveActivity")
                            .foregroundColor(.red)
                    }


                }
                
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
                            startLiveActivity()
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
    
    
    func startLiveActivity(){
        print(ActivityAuthorizationInfo().areActivitiesEnabled)
        let myWidgetAttributes = MyWidgetAttributes(name: "Sreinin")
        let initialContentState = MyWidgetAttributes.myWidgetContentStatus(value: 2)
        
        do {
             
            let myWidgetActivity = try Activity<MyWidgetAttributes>.request(attributes: myWidgetAttributes, contentState: initialContentState)
        }
        catch (let error){
            print("Error requesting  Live Activity \(error.localizedDescription)")
            alertMsg = "Error requesting Live Activity \(error.localizedDescription)"
            showAlert = true
        }
    }
 
    //Update Activity
    func updateActivity(activity : Activity<MyWidgetAttributes>) {
        Task {
            let updateStatus = MyWidgetAttributes.myWidgetContentStatus(value: 5)
            await activity.update(using: updateStatus)
        }
    }
    
    func endAllActivity() {
        Task {
            let activities = Activity<MyWidgetAttributes>.activities
            for activity in activities  {
                await activity.end(dismissalPolicy: .immediate)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ContentView()
        }
    }
}
