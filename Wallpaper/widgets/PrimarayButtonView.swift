//
//  PrimarayButtonView.swift
//  Wallpaper
//
//  Created by Brilliant Gamez on 6/13/22.
//

import SwiftUI

struct PrimarayButtonView: View {
    
    var text: String
    
    var body: some View {
        HStack{
            Text(text).font(.system(size: 22,weight: .bold)).foregroundColor(AppColor.colorWhite).padding([.vertical],4)
        }.padding().frame(minWidth: 0, maxWidth: .infinity).background(AppColor.buttonGradient).cornerRadius(22)
            .padding().padding([.horizontal]).padding([.horizontal],10)
    }
}

struct PrimarayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PrimarayButtonView(text: "Continue")
    }
}
