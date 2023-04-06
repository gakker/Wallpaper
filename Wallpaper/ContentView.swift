//
//  ContentView.swift
//  Wallpaper
//
//  Created by Brilliant Gamez on 6/9/22.
//

import SwiftUI


struct ContentView: View {
    
    @State var font = UIFont(name: "Helvetica Bold", size: 20.0)
    
    init(){
        for family in UIFont.familyNames {
             print(family)

             for names in UIFont.fontNames(forFamilyName: family){
             print("== \(names)")
             }
        }
    }
    
    var body: some View {
        Text("Hello")
        
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}

public extension Font {
  init(uiFont: UIFont) {
    self = Font(uiFont as CTFont)
  }
}
