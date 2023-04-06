//
//  WallpaperCatItem.swift
//  Wallpaper
//
//  Created by Brilliant Gamez on 6/24/22.
//

import SwiftUI

struct WallpaperCatItem: View {
    var category: WallpaperListModel
    var height: CGFloat
    var width: CGFloat
    
    @State var loadingMore: Bool = false
    @State var mWallpaperList : [WallpaperModel] = []
    @State var skip : Int = 0
    @State var count: Int = 0
    var limit : Int = 12
    
    var imageHelper = ImageCachedHelper()
    
    var body: some View {
        VStack{
            Spacer().frame(height: 20)
            HStack{
                Text(category.category_name).foregroundColor(AppColor.colorWhite).bold()
                Spacer()
            }.padding([.horizontal],16)
            

            
            VStack{
                ForEach(0..<count, id: \.self) { i in
                    WallpaperGroupItem(height: height, width: width, index: i,lastIndex: mWallpaperList.count,wallpapers: $mWallpaperList, imageHelper: imageHelper)
                            }
                
                if(mWallpaperList.count < category.wallpapers_count){
                    Button {
                        getWallpaperList()
                    } label: {
                        if loadingMore{
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: AppColor.colorWhite)).font(.system(size: 12)).frame(maxWidth: .infinity).padding().background(AppColor.colorWhite.opacity(0.1)).cornerRadius(10).padding([.horizontal])
                        }else{
                            Text(AppStrings.seeMore).foregroundColor(AppColor.colorWhite).font(.system(size: 20)).frame(maxWidth: .infinity).padding().background(AppColor.colorWhite.opacity(0.1)).cornerRadius(10).padding(10)
                        }
                    }.disabled(loadingMore)
                }
                
                if Global.isPremium == false {
                    ZStack{
                        Image("premium_background").resizable().frame(height: width*0.9).scaledToFill().clipped().cornerRadius(15)
//                        AppColor.colorBlack.opacity(0.7).cornerRadius(15)
                        VStack{
                            Spacer()
                            Text(AppStrings.welcomeThreeHeading).font(.system(size: 22)).bold().multilineTextAlignment(.center).foregroundColor(Color.white)
                            Spacer().frame(height: 20)
                            Text(AppStrings.trialText).font(.system(size: 18)).foregroundColor(AppColor.colorWhite)
                            NavigationLink {
                                PaymentView(back: true)
                            } label: {
                                HStack{
                                    Text(AppStrings.letStart).font(.system(size: 18,weight: .bold)).foregroundColor(AppColor.colorWhite).padding([.vertical],4)
                                }.padding([.vertical],10).padding([.horizontal]).frame(width: width*0.5).background(AppColor.buttonGradient).cornerRadius(22)
                                    .padding().padding([.horizontal]).padding([.horizontal],10)
                            }
                            
                            Spacer().frame(height: 20)

                        }
                    }.frame( height: width*0.9).padding([.horizontal],10)
                }

                
                
            }
            
            
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20){
//
//                ForEach(category.wallpapers,id: \.self){
//                    wallpaper in
//                    NavigationLink{
//                        WallpaperDetailView(wallpaper: wallpaper)
//                    }label :{
//                        WallpaperItem(wallpaper: wallpaper)
//                    }
//                }
//
//            }
            
//            ScrollView(.horizontal,showsIndicators: false){
//                            HStack(spacing:10){
//                                ForEach(category.wallpapers){
//                                    wallpaper in
//                                    NavigationLink{
//                                        WallpaperDetailView(wallpaper: wallpaper)
//                                    }label :{
//                                        WallpaperItem(wallpaper: wallpaper)
//                                    }
//                                }
//                            }.padding()
//            }
            
        }.onAppear{
            if mWallpaperList.isEmpty{
                mWallpaperList.append(contentsOf: category.wallpapers)
                getCount()
            }
        }
        
        
    }
    
    func getWallpaperList(){
        loadingMore = true
        skip+=1
        guard let url = URL(string: "\(Global.apiUrl)wallpaper/view-wallpaper-category")
        else {
            fatalError("Missing URL")
            
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        // prepare json data
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        let parameters: [String: Any] = [
            "category_id": category._id,
            "skip": skip,
            "limit": limit
        ]
        urlRequest.httpBody = parameters.percentEncoded()

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse
            else {
                return
                
            }

            
            if response.statusCode == 200 {
                
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedUsers = try JSONDecoder().decode(WallpapersResponse.self, from: data)
                        mWallpaperList.append(contentsOf: decodedUsers.wallpapers)
                        getCount()
                        loadingMore = false
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
    
    func getCount(){
        let val2: Float = Float(mWallpaperList.count)/6
        let fl : Float = val2.rounded(.up)
        let intValue: Int = Int(fl)
        count = intValue
        
    }
    
    private var splitArray: [[WallpaperModel]] {
            var result: [[WallpaperModel]] = []
            
            var list1: [WallpaperModel] = []
            var list2: [WallpaperModel] = []
            
        category.wallpapers.forEach { photo in
            let index = category.wallpapers.firstIndex {$0._id == photo._id }
                
                if let index = index {
                    if index % 2 == 0  {
                        list1.append(photo)
                    } else {
                        list2.append(photo)
                    }
                }
            }
            result.append(list1)
            result.append(list2)
            return result
            
        }
}

struct WallpaperCatItem_Previews: PreviewProvider {
    static var previews: some View {
        WallpaperCatItem(category: wallpaperResponse.categories[0],height: CGFloat(100),width: CGFloat(134))
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed: CharacterSet = .urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
