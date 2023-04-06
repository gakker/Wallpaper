//
//  PaymentPackageItem.swift
//  Wallpaper
//
//  Created by Brilliant Gamez on 6/15/22.
//

import Foundation
import SwiftUI
import RevenueCat

struct PaymentPackageItem: View {
    
    let index: Int
    let package: Package
    @Binding var maxValPerDay: Double
    @Binding var selectedPackage: Package?
//
    init(index: Int,package: Package, maxValPerDay: Binding<Double>, selectedPackage: Binding<Package?>){
        self.package = package
        self._selectedPackage = selectedPackage
        self.index = index
        self._maxValPerDay = maxValPerDay
    }
    
    
    
    var body: some View {
        
        Button {
            print("product Id: \(package.storeProduct.productIdentifier)")
            selectedPackage = package
        } label: {
            VStack{
                Text(getPopularity(product: package.storeProduct)).foregroundColor(getPopularity(product: package.storeProduct) == "." ? AppColor.colorBlack.opacity(0) : AppColor.colorWhite).font(.system(size: 12))
                ZStack{
                    VStack{
                        Text(getValue(product: package.storeProduct)).foregroundColor(AppColor.colorWhite).font(.system(size: 28)).multilineTextAlignment(.leading)
                        Text(getUnit(product: package.storeProduct)).foregroundColor(AppColor.colorWhite).font(.system(size: 12)).multilineTextAlignment(.leading)
                        Text(getDiscount(product: package.storeProduct)).font(.system(size: 8,weight: .bold)).padding([.horizontal],8).padding([.vertical],2).foregroundColor(AppColor.colorWhite).background(AppColor.colorButtonEnd).cornerRadius(10)
//                        if package.storeProduct.introductoryDiscount != nil{
//                            HStack(alignment: .bottom,spacing: 0){
//                                Text(package.storeProduct.localizedPriceString).foregroundColor(AppColor.colorWhite).font(.system(size: 18)).multilineTextAlignment(.leading)
//                                Text(getPriceString(product:package.storeProduct)).foregroundColor(AppColor.colorWhite).font(.system(size: 14)).multilineTextAlignment(.leading)
//                            }
//                        }else{
//                            Text(package.storeProduct.localizedPriceString).foregroundColor(AppColor.colorWhite).font(.system(size: 18)).multilineTextAlignment(.leading)
//                        }
                        Text(package.storeProduct.localizedPriceString).foregroundColor(AppColor.colorWhite).font(.system(size: 18)).multilineTextAlignment(.leading)
                        Spacer().frame(height: 5)
                        Text(getValuePerWeek(product: package.storeProduct)).foregroundColor(AppColor.colorWhite).font(.system(size: 10))
                    }.padding(5)
                    if package == selectedPackage{
                        VStack{
                            HStack{
                                Spacer()
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(AppColor.colorButtonStart).background(AppColor.colorWhite).cornerRadius(10).padding(8)
                            }
                            Spacer()
                        }
                    }
                }.frame(width: 120, height: 140).background(AppColor.paymentItemGradient).cornerRadius(20).overlay(
                    RoundedRectangle(cornerRadius: 20).stroke(package == selectedPackage ? AppColor.colorWhite : AppColor.colorWhite.opacity(0))
                        
                )
            }
                
          
        }
    }
    
    func getPriceString(product: StoreProduct) -> String{
        var value = ""
        if (product.subscriptionPeriod != nil) {
            let a = product.subscriptionPeriod!.value
            if(a>1){
                value = "/\(a) \(product.subscriptionPeriod!.unit)s".capitalized
            }else{
                value = "/\(product.subscriptionPeriod!.unit)".capitalized
            }
            
        } else{
            value = "Lifetime"
        }
        return value
    }
    
    
    
    func getPopularity(product: StoreProduct) -> String {
        
    
        var value = ""
        if index == 1 {
            value = "BEST OFFER"
        } else if index == 2 {
            value = "MOST POPULAR"
        } else{
            value = "."
        }
        
        return value
    }
    
    
    
    func getValue(product: StoreProduct) -> String{
        
        var value = ""
        
//        if product.introductoryDiscount != nil{
//            value = "\(product.introductoryDiscount!.subscriptionPeriod.value)"
//        }else{
//            if (product.subscriptionPeriod != nil) {
//                value = "\(product.subscriptionPeriod!.value)"
//            }else{
//                value = "1"
//            }
//        }
        if (product.subscriptionPeriod != nil) {
            value = "\(product.subscriptionPeriod!.value)"
        }else{
            value = "1"
        }
        return value
    }
    
    func getUnit(product: StoreProduct) -> String{
        
        var value = ""
        
//        if product.introductoryDiscount != nil{
//            let a = product.introductoryDiscount!.subscriptionPeriod.value
//            if(a>1){
//                value = "\(product.introductoryDiscount!.subscriptionPeriod.unit)s".capitalized
//            }else{
//                value = "\(product.introductoryDiscount!.subscriptionPeriod.unit)".capitalized
//            }
//        }else{
//            if (product.subscriptionPeriod != nil) {
//                let a = product.subscriptionPeriod!.value
//                if(a>1){
//                    value = "\(product.subscriptionPeriod!.unit)s".capitalized
//                }else{
//                    value = "\(product.subscriptionPeriod!.unit)".capitalized
//                }
//
//            } else{
//                value = "Time"
//            }
//        }
        
        if (product.subscriptionPeriod != nil) {
            let a = product.subscriptionPeriod!.value
            if(a>1){
                value = "\(product.subscriptionPeriod!.unit)s".capitalized
            }else{
                value = "\(product.subscriptionPeriod!.unit)".capitalized
            }
            
        } else{
            value = "Time"
        }
        
        return value
    }
    
    func getDiscount(product: StoreProduct) -> String{
        var value = ""
       
        
        if product.introductoryDiscount != nil {
            value = "3 Days Free Trial"
        } else{
            
            var maxValue : Double = 1.0
            
            //Finding the per day value of current product
            if product.subscriptionPeriod != nil{
                var days : Int = 0
                var unit : String = "\(product.subscriptionPeriod!.unit)"
                
                if unit == "day"{
                    days = product.subscriptionPeriod!.value
                }else if unit == "week"{
                    days = product.subscriptionPeriod!.value * 7
                }else if unit == "month"{
                    days = product.subscriptionPeriod!.value * 30
                }else if unit == "year"{
                    days = product.subscriptionPeriod!.value * 365
                }else {
                    days = 0
                }
                
                let pricePerDay = product.price/Decimal(days)
                
                let doubeValue = pricePerDay.doubleValue
                
                maxValue = doubeValue
                
                let percentSave = 100.0 - (maxValue*100/maxValPerDay)
                
                print("Max Value of All Packeges: \(maxValPerDay)")
                print("Max Value of Package \(index): \(maxValue)")
                print("Percent Save")
                
                if percentSave <= 0 {
                    value = "Top Choice"
                }else{
                    value = "SAVE \(String(format: "%.0f", percentSave))%"
                }
                
            }else{
                value = "Lifetime"
            }
        }
        
        return value
    }
    
    func getValuePerWeek(product: StoreProduct) -> String{
        var value = ""
        
        if product.subscriptionPeriod != nil{
            var days : Int = 0
            var unit : String = "\(product.subscriptionPeriod!.unit)"
            
            if unit == "day"{
                days = product.subscriptionPeriod!.value
            }else if unit == "week"{
                days = product.subscriptionPeriod!.value * 7
            }else if unit == "month"{
                days = product.subscriptionPeriod!.value * 30
            }else if unit == "year"{
                days = product.subscriptionPeriod!.value * 365
            }else {
                days = 0
            }
            
            let pricePerweek = product.price*7.0/Decimal(days)
            
            let doubeValue = pricePerweek.doubleValue
            
            
            
            value = "\(String(format: "%.2f", doubeValue))/week"
        }else{
            value = "Lifetime"
        }
        
        
        return value
    }
}

extension Decimal {
    var doubleValue:Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
