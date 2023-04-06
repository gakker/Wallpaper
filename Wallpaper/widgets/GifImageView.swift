//
//  GifImageView.swift
//  Wallpaper
//
//  Created by Brilliant Gamez on 8/22/22.
//

import SwiftUI

struct GifImageView: View {
    
    var width: CGFloat
    var height: CGFloat
    var url: String
    
    @State var imageData: Data?

      var body: some View {
        VStack {
          if let data = imageData {
              GIFImage(data: data)
                  .frame(width: width,height: height).background(AppColor.transBlack).cornerRadius(10)
          } else {
              Text("Loading...").foregroundColor(AppColor.colorWhite)
              .onAppear(perform: loadData)
          }
        }
      }

      private func loadData() {
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
          imageData = data
        }
        task.resume()
      }
}

struct GifImageView_Previews: PreviewProvider {
    static var previews: some View {
        GifImageView(width: CGFloat(200), height: CGFloat(200), url: "")
    }
}
