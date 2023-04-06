//
//  GifWallpaperItem.swift
//  Wallpaper
//
//  Created by Brilliant Gamez on 8/22/22.
//

import SwiftUI

struct GifWallpaperItem: View {
    var wallpaper : WallpaperModel
    var width: CGFloat
    var height: CGFloat
    var imageHelper: ImageCachedHelper
    @State private var shoulShowNextScreen = false
    @State private var imageData: Data? = nil
    
    var body: some View {
        NavigationLink(isActive: $shoulShowNextScreen, destination: { CustomWallpaperView(wallpaper: wallpaper,data: imageData).navigationBarHidden(true).statusBar(hidden: true) }){
            Button {
//
                if imageData != nil{
                    shoulShowNextScreen = true
                }
            } label: {
                
                ZStack{
                    VStack {
                      if let data = imageData {
                          GIFImage(data: data)
                              .frame(width: width,height: height).background(AppColor.transBlack).cornerRadius(10)
                      } else {
                          ZStack{
                              Color.gray.opacity(0.3)
                              ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white.opacity(0.3)))
                          }
                      }
                    }
                    VStack{
                        HStack{
                            Spacer()
                            ZStack{
                                if(wallpaper.advertisement){
                                    Image("video").resizable().frame(width: 19, height: 14)
                                }
                                else if(wallpaper.paid){
                                    Image("premium").resizable().frame(width: 16, height: 12)
                                }else{
                                    Image("free").resizable().frame(width: 16, height: 12)
                                }
                            }.frame(width: 40, height: 24).background(AppColor.colorBlack.opacity(0.5)).cornerRadius(50).overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.white, lineWidth: 0.5)
                            )
                        }.padding(10)
                        Spacer()
                    }
                }.edgesIgnoringSafeArea(.all).frame(width: width,height: height).cornerRadius(10).onAppear{
                    imageData = imageHelper.getValue(key: wallpaper._id)
                }
            }
        }
    }
    
    private func loadData() {
        let task = URLSession.shared.dataTask(with: URL(string: wallpaper.url)!) { data, response, error in
        imageData = data
      }
      task.resume()
    }
}

//struct GifWallpaperItem_Previews: PreviewProvider {
//    static var previews: some View {
//        GifWallpaperItem()
//    }
//}
