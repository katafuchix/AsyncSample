//
//  RandomAPIExample3View.swift
//  AsyncSample
//

import SwiftUI

// エラー定義
enum AddressError: Error {
    case serverError
    case noData
}

struct RandomAPIErrorExampleView: View {
    
    func asyncLoadAddress() async throws -> Address {
        let url = URL(string: "https://random-data-api.com/api/address/random_address")!
        // データを取得
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // レスポンスコードが200でなければエラーを返す
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw AddressError.serverError }

        // JSONを解析してAddress構造体にマッピング
        // データがなければエラーを返す
        guard let address = try? JSONDecoder().decode(Address.self, from: data) else { throw AddressError.noData }
        return address
    }
    
    var body: some View {
        Button("実行") {
            Task {
                do {
                    let address = try await asyncLoadAddress()
                    print(address)
                } catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    RandomAPIErrorExampleView()
}
