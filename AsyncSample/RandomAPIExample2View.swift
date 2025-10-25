//
//  RandomAPIExample2View.swift
//  AsyncSample
//

import SwiftUI

struct RandomAPIExample2View: View {
    
    @State var text: String = "Hello, Swift!"
    
    var body: some View {
        Button(text) {
            Task(priority: .high) {
                let address1 = try await asyncLoadAddress()
                print("address1")
                print(address1)
                //text = address.full_address
                
                let address2 = try await asyncLoadAddress()
                print("address2")
                print(address2)
                //text = address.full_address
            }
        }
    }
    
    func asyncLoadAddress() async throws -> Address {
        let url = URL(string: "https://random-data-api.com/api/address/random_address")!
        // データを取得
        let (data, _) = try await URLSession.shared.data(from: url)
        // JSONを解析した後、Address構造体にマッピングされたデータを取り出す
        let address = try! JSONDecoder().decode(Address.self, from: data)
        return address
    }
}

#Preview {
    RandomAPIExample2View()
}
