//
//  TableDetailView.swift
//  iDine
//
//  Created by Sreynin on 2023/06/29.
//

import SwiftUI
import ActivityKit

struct TabDetailView: View {
    
    @State var selectedView = 1
    @State var showAlert: Bool = false
    @State var alertMsg: String = ""
    
    
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

@available(iOS 16.2, *)
struct TabDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TabDetailView()
    }
}
