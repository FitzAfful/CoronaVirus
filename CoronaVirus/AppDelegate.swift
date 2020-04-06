//
//  AppDelegate.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] {
            NSLog("[RemoteNotification] applicationState: \(applicationStateString) didFinishLaunchingWithOptions for iOS9: \(userInfo)")
        }
        application.registerForRemoteNotifications()
        requestNotificationAuthorization(application: application)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.tokenRefreshNotification),
                                               name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)

        Messaging.messaging().delegate = self
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
           print("FCM Token: \(fcmToken)")
           print("Done Registration Token")
       }
       func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
           Messaging.messaging().setAPNSToken(deviceToken, type: MessagingAPNSTokenType.unknown)

           var token = ""
           for i in 0..<deviceToken.count {
               token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
           }
           UserDefaults.standard.set(token, forKey: "token")
           print("Device Token:", token)

           InstanceID.instanceID().instanceID { (result, error) in
               if(error != nil){
                   print("Instance ID Error: \(error.debugDescription)")
               }else{
                   token = result!.token
                   UserDefaults.standard.set(token, forKey: "instanceToken")
               }
           }
       }

       func application(_ application: UIApplication,
                        didFailToRegisterForRemoteNotificationsWithError error: Error) {
           print("Oh no! Failed to register for remote notifications with error \(error)")
       }

       @objc func tokenRefreshNotification(_ notification: Notification) {
           var token = ""
           InstanceID.instanceID().instanceID { (result, error) in
               if(error != nil){
                   print("Instance ID Error: \(error.debugDescription)")
               }else{
                   token = result!.token
               }
           }
        print("Token: \(token)")
           connectToFcm()
       }

       func requestNotificationAuthorization(application: UIApplication) {
           if #available(iOS 10.0, *) {
               UNUserNotificationCenter.current().delegate = self
               let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
               UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
           } else {
               let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
               application.registerUserNotificationSettings(settings)
           }
       }

       func connectToFcm() {
           Messaging.messaging().isAutoInitEnabled = true
       }

       var applicationStateString: String {
           if UIApplication.shared.applicationState == .active {
               return "active"
           } else if UIApplication.shared.applicationState == .background {
               return "background"
           }else {
               return "inactive"
           }
       }

}


@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    // iOS10+, called when presenting notification in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print("[UserNotificationCenter] applicationState: \(applicationStateString) willPresentNotification: \(userInfo)")
        //TODO: Handle foreground notification
        //self.managePush(userInfo: userInfo, from: "foreground")
        completionHandler([.alert])
    }

    // iOS10+, called when received response (default open, dismiss or custom action) for a notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("[UserNotificationCenter II] applicationState: \(applicationStateString) didReceiveResponse: \(userInfo)")
        //TODO: Handle background notification
        //managePush(userInfo: userInfo, from: "background")
        completionHandler()
    }
}
