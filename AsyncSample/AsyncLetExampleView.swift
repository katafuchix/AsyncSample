//
//  AsyncLetExampleView.swift
//  AsyncSample
//

import SwiftUI
import UIKit

// 犬画像情報を格納す構造体
struct Dog: Codable  {
    let message: String
    let status: String
}

struct AsyncLetExampleView: View {
    
    // 非同期に犬の画像を取得するメソッド
    func loadDogImage(index: Int) async -> UIImage? {
        // ランダムな犬の画像情報を返すAPIからJSONを取得
        let imageURL = URL(string: "https://dog.ceo/api/breeds/image/random")!
        let request = URLRequest(url: imageURL)
        let (data, _) = try! await URLSession.shared.data(for: request, delegate: nil)
        let decoded = try? JSONDecoder().decode(Dog.self, from: data)
        print(decoded)
        // JSON内の画像URLから画像を取得してUIImageで返す
        if let message = decoded?.message {
            let request = URLRequest(url: URL(string: message)!)
            let (data, _) = try! await URLSession.shared.data(for: request, delegate: nil)
            print("Loaded Dog Image index: \(index)")
            return UIImage(data: data) ?? nil
        }
        return nil
    }
    
    var body: some View {
        Button("実行") {
            Task {
                async let Image1 = loadDogImage(index: 1)
                async let Image2 = loadDogImage(index: 2)
                async let Image3 =  loadDogImage(index: 3)
                
                let images = await [Image1, Image2, Image3]
                
                print(images)
            }
        }
    }
}

#Preview {
    AsyncLetExampleView()
}
