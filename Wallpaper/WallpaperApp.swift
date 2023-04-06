//
//  WallpaperApp.swift
//  Wallpaper
//
//  Created by Brilliant Gamez on 6/9/22.
//

import SwiftUI
import RevenueCat
import Adjust
import AppLovinSDK
// TODO: Add Firebase dependency and uncomment it
import FirebaseCore
import UserNotifications
// TODO: Add Firebase dependency and uncomment it
import FirebaseMessaging

extension UserDefaults {
    
    var welcomeScreenShown: Bool {
        get{
            return (UserDefaults.standard.value(forKey: "welcomeScreenShown") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "welcomeScreenShown")
        }
    }
    
    var isPremiumAccount: Bool {
        get{
            return (UserDefaults.standard.value(forKey: "premiumAccount") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "premiumAccount")
        }
    }
}


@main
struct WallpaperApp: App {
    
    
    // TODO: Add Firebase dependency and uncomment it
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init(){
        
//        FirebaseApp.configure()
        //Initilaization of MAX
        // Please make sure to set the mediation provider value to "max" to ensure proper functionality
                ALSdk.shared()!.mediationProvider = "max"

//                ALSdk.shared()!.userIdentifier = "USER_ID"

                ALSdk.shared()!.initializeSdk { (configuration: ALSdkConfiguration) in
                    // Start loading ads
                }
        
        
        //Initialization of ReveunueCat
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_RmXnCXFYKpAIKpygHzRLXzBduFC")
        Purchases.shared.collectDeviceIdentifiers()
        
        
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            // access latest customerInf
            if error == nil {
                if customerInfo?.entitlements["premium"]?.isActive == true {
                  // user has access to "your_entitlement_id"
                    Global.isPremium = true
                }
            }
        }
        
        
        //Initialization of Adjust
        let yourAppToken = AdjustTokens.appToken

        let environment = ADJEnvironmentSandbox
        let adjustConfig = ADJConfig(
            appToken: yourAppToken,
            environment: environment,allowSuppressLogLevel: true)

        Adjust.appDidLaunch(adjustConfig)
        
        if let adjustId = Adjust.adid(){
            print("adjustId: \(adjustId)")
            Purchases.shared.setAdjustID(adjustId)
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            // TODO: Change it to WelcomeOneView
//            WelcomeView()
//            HomeView()
            if UserDefaults.standard.welcomeScreenShown{
                if Global.isPremium{
                    HomeView()
                }else{
                    WelcomeThreeView()
                }

            }else{
                WelcomeView().onAppear(perform: {
                    UserDefaults.standard.welcomeScreenShown = true
                })
            }
        }
    }
}


// TODO: Add Firebase dependency and uncomment it
class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        Messaging.messaging().delegate = self

        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions){
                success, error in
                if error != nil {
                    print("No Error")
                }else{
                    print("Error \(error)")
                }
            }
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        getWallpapersCategories()
        
        return true
    }
    
    func getWallpapersCategories(){
        guard let url = URL(string: "\(Global.apiUrl)wallpaper/view-wallpapers-details")
        else {
            fatalError("Missing URL")
            
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"

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
                        let decodedUsers = try JSONDecoder().decode(WallpaperCatModel.self, from: data)
                        if decodedUsers.status{
                            LocalDBHelper.writeData(data,fileName: Global.catJsonFileName)
                            AppUtils.saveImages(categoreis: decodedUsers.categories,index: 0, cachedHeler: ImageCachedHelper())
                        }
//                        if(decodedUsers.categories.count != 0){
//                            selectedCat = decodedUsers.categories[0]._id
//                        }
//                        mWallpaperCatModel = decodedUsers
//                        isLoading = false
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }else{
                print("Response: \(response)")
                print("Internet Error")
            }
        }

        dataTask.resume()
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

      let deviceToken:[String: String] = ["token": fcmToken ?? ""]
        print("Device token: ", deviceToken)
        // This token can be used for testing notifications on FCM
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                               willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
    }

    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.banner, .badge, .sound]])
  }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Registered for Apple Remote Notifications")
            Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register")
    }


  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID from userNotificationCenter didReceive: \(messageID)")
    }

    print(userInfo)

    completionHandler()
  }
}
