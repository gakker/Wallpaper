//
//  MyWallpaperItem.swift
//  Wallpaper
//
//  Created by Brilliant Gamez on 8/22/22.
//

import SwiftUI

struct MyWallpaperItem: View {
    
    var wallpaper : WallpaperModel
    var width: CGFloat
    var height: CGFloat
    @State var imageData: Data?
    @State var shoulShowNextScreen = false
    var imageHelper: ImageCachedHelper
    
    var body: some View {
        NavigationLink(isActive: $shoulShowNextScreen, destination: { CustomWallpaperView(wallpaper: wallpaper,data: imageData).navigationBarHidden(true).statusBar(hidden: true) }){
            Button {
//
                if imageData != nil{
                    shoulShowNextScreen = true
                }
            } label: {
                
                ZStack{
//                                    MyAsyncImage(url: URL(string: wallpaper.url)!,
//                                                 placeholder: { ZStack{
//                                        Color.gray.opacity(0.3)
//                                        ProgressView()
//                                    } },
//                                                 image: { Image(uiImage: $0).resizable() })
                    if imageData != nil{
                        Image(uiImage: UIImage(data: imageData!)!).resizable()
                    }else{
                        Color.gray.opacity(0.3)
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
                }.edgesIgnoringSafeArea(.all).frame(width: width,height: height).cornerRadius(10)
                    .onAppear{
                        let data = imageHelper.getValue(key: wallpaper._id)
                        if data == nil{
                            AppUtils.getDataFromUrl(url: URL(string: wallpaper.url)!) { mData, response, error in
                                if error == nil && mData != nil{
                                    imageData = mData
                                    imageHelper.saveValue(key: wallpaper._id, value: mData!)
                                }
                            }
                        }else{
                            imageData = data
                        }
                    }
            }
        }

        }
}

//struct MyWallpaperItem_Previews: PreviewProvider {
//    static var previews: some View {
//        MyWallpaperItem()
//    }
//}
