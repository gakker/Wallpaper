//
//  AppColors.swift
//  Wallpaper
//
//  Created by Brilliant Gamez on 6/10/22.
//

import Foundation
import SwiftUI

class AppColor{
    let backgroundColors: [Color] = [Color(red: 0.2, green: 0.85, blue: 0.7), Color(red: 0.13, green: 0.55, blue: 0.45)]
    
    static var colorPrimary: Color = Color(red: 0.69, green: 0.92, blue: 0.82)
    
    static var grey: Color = Color(hexStringToUIColor(hex: "#252525"))
    
    static var lightGrey2: Color = Color.white.opacity(0.04)
    
    static var colorPrimaryDark: Color = Color(red: 0.09, green: 0.02, blue: 0.24)
    
    static var colorButtonStart: Color = Color(red: 0.54, green: 0.17, blue: 1)
    
    static var colorButtonEnd: Color = Color(red: 0.43, green: 0.17, blue: 1)
    
    static var colorPrimaryLight: Color = Color(red: 0.86, green: 0.97, blue: 0.93)
    
    static var colorSecondary: Color = Color(red: 0.27, green: 0.27, blue: 0.28)
    
    static var colorSecondaryDark: Color = Color(red: 0.23, green: 0.22, blue: 0.23)
    
    static var colorSecondaryLight: Color = Color(red: 0.27, green: 0.28, blue: 0.30)
    
    static var colorDarkGrey: Color = Color(red: 0.45, green: 0.45, blue: 0.45)
    
    static var colorGrey: Color = Color(red: 0.66, green: 0.66, blue: 0.66)
    
    static var colorLightGrey: Color = Color(red: 0.73, green: 0.73, blue: 0.73)
    
    static var colorBlack: Color = Color(red: 0, green: 0, blue: 0)
    
    static var colorOrange: Color = Color(red: 0.99, green: 0.60, blue: 0.01)
    
    static var sheetColor: Color = Color(red: 0.01, green: 0.01, blue: 0.17)
    
    static var colorWhite: Color = Color(red: 1, green: 1, blue: 1)
    
    static var lightGrey: Color = Color.white.opacity(0.04)
    
    let whiteGradientColors: [Color] = [colorSecondary.opacity(0), colorSecondary.opacity(0.48) , colorSecondary.opacity(0.48),colorSecondary.opacity(1)]
    
    static var welcomeGradient = LinearGradient(gradient: Gradient(colors: [colorPrimaryDark.opacity(0),colorPrimaryDark.opacity(0), colorPrimaryDark.opacity(0.48),colorPrimaryDark.opacity(1),colorPrimaryDark.opacity(1)]), startPoint: .top, endPoint: .bottom)
    
    static var paymentGradient = LinearGradient(gradient: Gradient(colors: [colorPrimaryDark.opacity(0), colorPrimaryDark.opacity(0.48),colorPrimaryDark.opacity(1),colorPrimaryDark.opacity(1)]), startPoint: .top, endPoint: .bottom)
    
    static var buttonGradient = LinearGradient(gradient: Gradient(colors: [colorButtonStart, colorButtonEnd,colorButtonEnd,colorButtonEnd,colorButtonEnd,colorButtonEnd]), startPoint: .leading, endPoint: .trailing)
    
    static var greenGradient = LinearGradient(gradient: Gradient(colors: [Color.green,Color.green.opacity(0.5),Color.green.opacity(0.5),Color.green.opacity(0.5),Color.green.opacity(0.5),Color.green.opacity(0)]), startPoint: .top, endPoint: .bottom)
    
    static var paymentItemGradient = LinearGradient(gradient: Gradient(colors: [colorButtonStart.opacity(0.1),colorButtonEnd.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
    
    
    
    
    //Wallpaper App
    static var colorHomeBGStart: Color = Color(red: 0.15, green: 0.03, blue: 0.28)
    
    static var colorHomeBGEnd: Color = Color(red: 0.07, green: 0.03, blue: 0.28)
    
    static var colorHomeBG = LinearGradient(gradient: Gradient(colors: [colorHomeBGStart, colorHomeBGStart,colorHomeBGEnd,colorHomeBGEnd,colorHomeBGEnd]), startPoint: .top, endPoint: .bottom)
    
    static var colorBottomBG: Color = Color(red: 0.01, green: 0.01, blue: 0.16)
    
    static var colorTransparentWhite = colorWhite.opacity(0.1)
    
    static var transBlack = colorBlack.opacity(0.3)
    
    static var navigationColor = Color(hexStringToUIColor(hex: "#030328"))
    
    static var settingG1 = Color(hexStringToUIColor(hex: "#6F2CFF"))
    static var settingG2 = Color(hexStringToUIColor(hex: "#C82CFF"))
    
    
    static var unselectColor = Color(hexStringToUIColor(hex: "#7070A8"))
    static var orange = Color(hexStringToUIColor(hex: "#E29909"))
    
    static var settingItemGradient = LinearGradient(gradient: Gradient(colors: [settingG1.opacity(0.25),settingG2.opacity(0.25)]), startPoint: .leading, endPoint: .trailing)
    
    static var settingItemGradient2 = LinearGradient(gradient: Gradient(colors: [settingG2,settingG1]), startPoint: .leading, endPoint: .trailing)
    
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
}
