//
//  RandomAPIExample3View.swift
//  AsyncSample
//
//  Created by cano on 2023/12/05.
//

import SwiftUI

struct RandomAPIExample3View: View {
    
    @State var text: String = "Hello, Swift!"
    
    var body: some View {
        Button("実行") {
            Task.detached(priority: .background) {
                let address = try await asyncLoadAddress()
                
                // ドキュメントディレクトリまでのURL
                let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                // address.txtの名前でファイルを作成
                let fileURL = documentDirectory.appendingPathComponent("address.txt")
                print(fileURL)
                // ファイルに addressのJSONを書き込み
                let encoder = JSONEncoder()
                try encoder.encode(address).write(to: fileURL)
                print(address.full_address)
            }
            
            Task.detached(priority: .background) {
                let address = try await asyncLoadAddress()
                
                // ドキュメントディレクトリまでのURL
                let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                // address.txtの名前でファイルを作成
                let fileURL = documentDirectory.appendingPathComponent("address.txt")
                print(fileURL)
                // ファイルに addressのJSONを書き込み
                let encoder = JSONEncoder()
                try encoder.encode(address).write(to: fileURL)
                print(address.full_address)
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
    RandomAPIExample3View()
}
