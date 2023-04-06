//
//  Network.swift
//  Wallpaper
//
//  Created by Brilliant Gamez on 6/30/22.
//

import Foundation

class Network: ObservableObject {
    @Published var wallpaerCatModel: WallpaperCatModel = WallpaperCatModel(status: false, message: "Default Message", categories: [])
    func getUsers() -> WallpaperCatModel{
        guard let url = URL(string: "BASE_URL") else { fatalError("Missing URL") }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedUsers = try JSONDecoder().decode(WallpaperCatModel.self, from: data)
                        self.wallpaerCatModel = decodedUsers
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
        return self.wallpaerCatModel
    }
}
