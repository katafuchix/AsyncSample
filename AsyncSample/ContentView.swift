//
//  ContentView.swift
//  AsyncSample
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Random API Example")) {
                    NavigationLink("Random API Example1 View", destination: RandomAPIExample1View())
                    
                    NavigationLink("Random API Example2 View", destination: RandomAPIExample2View())
                    
                    NavigationLink("Random API Example3 View", destination: RandomAPIExample3View())
                    
                    NavigationLink("Random API Example4 View", destination: RandomAPIExample4View())
                }
                
                Section(header: Text("Async Example")) {
                    NavigationLink("Actor Example View", destination: ActorExampleView())
                    
                    NavigationLink("AsyncLet Example View", destination: AsyncLetExampleView())
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
