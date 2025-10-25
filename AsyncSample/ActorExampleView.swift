//
//  ActorExampleView.swift
//  AsyncSample
//

import SwiftUI

actor Counter {
   var count: Int = 0

   func updateCount() -> Int {
      count += 1
      return count
   }
}

struct ActorExampleView: View {
    var counter: Counter = Counter()
    @State var timer1: Timer? = Timer()
    @State var timer2: Timer? = Timer()
    
    var body: some View {
        VStack (spacing: 30) {
            Button("実行") {
                timer1 = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (timer) in
                    Task(priority: .background) {
                        print(await counter.updateCount())
                    }
                }
                
                timer2 = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { (timer) in
                    Task(priority: .high) {
                        print(await counter.updateCount())
                    }
                }
            }
            
            Button("停止") {
                timer1?.invalidate()
                timer2?.invalidate()
            }
        }
    }
}

#Preview {
    ActorExampleView()
}
