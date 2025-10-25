//
//  RandomAPIExample1View.swift
//  AsyncSample
//

import SwiftUI

// アドレス情報を格納する構造体
struct Address: Codable  {
    let id: Int
    let uid: String
    let city: String
    let street_name: String
    let street_address: String
    let secondary_address: String
    let building_number: String
    let mail_box: String
    let community: String
    let zip_code: String
    let zip: String
    let postcode: String
    let time_zone: String
    let street_suffix: String
    let city_suffix: String
    let city_prefix: String
    let state: String
    let state_abbr: String
    let country: String
    let country_code: String
    let latitude: Double
    let longitude: Double
    let full_address: String
}

struct RandomAPIExample1View: View {
    
    func asyncLoadAddress() async throws -> Address {
        let url = URL(string: "https://random-data-api.com/api/address/random_address")!
        // データを取得
        let (data, _) = try await URLSession.shared.data(from: url)
        // JSONを解析した後、Address構造体にマッピングされたデータを取り出す
        let address = try! JSONDecoder().decode(Address.self, from: data)
        return address
    }
    
    var body: some View {
        Button("実行") {
            Task {
                let address = try await asyncLoadAddress()
                print(address)
            }
        }
    }
}

#Preview {
    RandomAPIExample1View()
}
