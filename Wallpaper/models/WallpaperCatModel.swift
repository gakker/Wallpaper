//
//  WallpaperCatModel.swift
//  Wallpaper
//
//  Created by Brilliant Gamez on 6/24/22.
//

import Foundation
struct WallpaperCatModel: Hashable, Codable{
    var status: Bool
    var message: String
    var categories: [WallpaperListModel]
}
