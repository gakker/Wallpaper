//
//  WallpaperItem.swift
//  Wallpaper
//
//  Created by Brilliant Gamez on 6/24/22.
//

import SwiftUI

struct WallpaperItem: View {
    var wallpaper: WallpaperModel
    
    var body: some View {
        ZStack{
            MyAsyncImage(url: URL(string: wallpaper.url)!,
                         placeholder: { ZStack{
                Color.gray.opacity(0.3)
                ProgressView()
            } },
                         image: { Image(uiImage: $0).resizable() })
            .frame(idealWidth: UIScreen.main.bounds.width * 0.5,idealHeight: UIScreen.main.bounds.width * 0.95)
                .cornerRadius(25)
            
            
        }
    }
}

struct WallpaperItem_Previews: PreviewProvider {
    static var previews: some View {
        WallpaperItem(wallpaper: wallpaperResponse.categories[0].wallpapers[0])
    }
}
