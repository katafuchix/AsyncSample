//
//  RandomAPIExample4View.swift
//  AsyncSample
//

import SwiftUI

struct RandomAPIExample4View: View {
    
    func asyncLoadAddress(completion: @escaping (Result<Address, Error>) -> Void) async {

        let url = URL(string: "https://random-data-api.com/api/address/random_address")!
        
        // データを取得
        let (data, response) = try! await URLSession.shared.data(from: url)
        
        // レスポンスコードが200でなければエラーを返す
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            completion(.failure(AddressError.serverError))
            return
        }

        // JSONを解析してAddress構造体にマッピング
        // データがなければエラーを返す
        guard let address = try? JSONDecoder().decode(Address.self, from: data) else {
            completion(.failure(AddressError.noData))
            return
        }
        
        completion(.success(address))
    }
    
    var body: some View {
        Button("実行") {
            Task {
                await asyncLoadAddress { result in
                    switch result {
                    case .success(let address):
                        print(address)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    RandomAPIExample4View()
}
