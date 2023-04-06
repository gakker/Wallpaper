//
//  WallpapersResponse.swift
//  Wallpaper
//
//  Created by Brilliant Gamez on 7/20/22.
//

import Foundation
struct WallpapersResponse: Hashable, Codable{
    var status: Bool
    var message: String
    var wallpapers: [WallpaperModel]
}
