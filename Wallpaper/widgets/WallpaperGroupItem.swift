//
//  WallpaperGroupItem.swift
//  Wallpaper
//
//  Created by Brilliant Gamez on 7/7/22.
//

import SwiftUI

struct WallpaperGroupItem: View {
    
    var height: CGFloat
    var width: CGFloat
    var index: Int
    var lastIndex: Int
    @Binding var wallpapers: [WallpaperModel]
    var imageHelper: ImageCachedHelper
    
    var body: some View {
        VStack{
            HStack{
                if index*6+0 < lastIndex{
                    if wallpapers[index*6+0].type=="image/gif"{
                        GifWallpaperItem(wallpaper: wallpapers[index*6+0],width: width*0.625, height: height*0.5, imageHelper: imageHelper)
                    }else{
                        MyWallpaperItem(wallpaper: wallpapers[index*6+0],width: width*0.625, height: height*0.5, imageHelper: imageHelper)
                    }
                }
                
                Spacer()
                
                VStack{
                    if index*6+1 < lastIndex{
                        if wallpapers[index*6+1].type=="image/gif"{
                            GifWallpaperItem(wallpaper: wallpapers[index*6+1],width: width*0.3,height: height*0.245, imageHelper: imageHelper)
                        }else{
                            MyWallpaperItem(wallpaper: wallpapers[index*6+1],width: width*0.3,height: height*0.245, imageHelper: imageHelper)
                        }
                    }
                    
                    Spacer()
                    
                    if index*6+2 < lastIndex {
                        if wallpapers[index*6+2].type=="image/gif"{
                            GifWallpaperItem(wallpaper: wallpapers[index*6+2],width: width*0.3,height: height*0.245, imageHelper: imageHelper)
                        }else{
                            MyWallpaperItem(wallpaper: wallpapers[index*6+2],width: width*0.3,height: height*0.245, imageHelper: imageHelper)
                        }
                    }
                }
            }
            
            if index*6+3 < lastIndex{
                HStack{
                    if index*6+3 < lastIndex {
                        if wallpapers[index*6+3].type=="image/gif"{
                            GifWallpaperItem(wallpaper: wallpapers[index*6+3],width: width*0.3,height: height*0.24, imageHelper: imageHelper)
                        }else{
                            MyWallpaperItem(wallpaper: wallpapers[index*6+3],width: width*0.3,height: height*0.24, imageHelper: imageHelper)
                        }
                    }
                    
                    Spacer()
                    
                    if index*6+4 < lastIndex {
                        if wallpapers[index*6+4].type=="image/gif"{
                            GifWallpaperItem(wallpaper: wallpapers[index*6+4],width: width*0.3,height: height*0.24, imageHelper: imageHelper)
                        }else{
                            MyWallpaperItem(wallpaper: wallpapers[index*6+4],width: width*0.3,height: height*0.24, imageHelper: imageHelper)
                        }
                        
                    }else{
                        Spacer().frame(width: width*0.3)
                    }
                    
                    Spacer()
                    
                    if index*6+5 < lastIndex {
                        if wallpapers[index*6+5].type=="image/gif"{
                            GifWallpaperItem(wallpaper: wallpapers[index*6+5],width: width*0.3,height: height*0.24, imageHelper: imageHelper)
                        }else{
                            MyWallpaperItem(wallpaper: wallpapers[index*6+5],width: width*0.3,height: height*0.24, imageHelper: imageHelper)
                        }
                    }else{
                        Spacer().frame(width: width*0.3)
                    }
                }
            }
        }.padding([.horizontal],10)
    }
}






//struct WallpaperGroupItem_Previews: PreviewProvider {
//    static var previews: some View {
//        WallpaperGroupItem(height: CGFloat(300), width: CGFloat(150),index: 0,lastIndex: 21,wallpapers: wallpaperResponse.categories[0].wallpapers)
//    }
//}
