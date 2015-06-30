//
//  AppDelegate.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import UIKit
import Fabric
//import Crashlytics
import ParseCrashReporting

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

//        Fabric.with([Crashlytics()])
        //MARK: Parse
        ParseCrashReporting.enable()
        Parse.enableLocalDatastore()

        Profile.registerSubclass()
        CrewMember.registerSubclass()
        Transaction.registerSubclass()
        Event.registerSubclass()

        Parse.setApplicationId("WKvDyqa7Hs23bkdbhPqAM4eadylYMxRlKTboJ56G", clientKey: "JhKakKAmnmp5Zt1dcrlXYtn4phHe9yf6Z3GmxuTp")
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)

        //MARK: Profile
        if PFUser.currentUser() != nil
        {
            Profile.queryForCurrentUserProfile({ (profile, error) -> Void in
                UniversalProfile.sharedInstance.profile = profile
            })
        }

        //MARK: UI
        setUpUI()
        pushSetup()

//        Crashlytics.sharedInstance().crash()

        return true
    }

    func setUpUI()
    {
        UINavigationBar.appearance().tintColor = UIColor.customRedColor()
        UITabBar.appearance().selectedImageTintColor = UIColor.customRedColor()
    }

    func pushSetup()
    {
        if (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0
        {
            let notificationSettings = UIUserNotificationSettings(forTypes: .Sound | .Alert | .Badge, categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
            UIApplication.sharedApplication().registerForRemoteNotifications()
        }
        else
        {
            let notificationTypes : UIRemoteNotificationType = .Alert | .Badge | .Sound
            UIApplication.sharedApplication().registerForRemoteNotificationTypes(notificationTypes)
        }
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData)
    {
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.addUniqueObject("Workday", forKey: "channels")
        currentInstallation.saveInBackgroundWithBlock { (succeeded, error) -> Void in

            if let someUser = PFUser.currentUser()
            {
                UniversalProfile.sharedInstance.profile?.setValue(currentInstallation, forKey: "installation")
                UniversalProfile.sharedInstance.profile?.saveInBackgroundWithBlock(nil)

            }

            println("installation saved")
        }
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject])
    {
        PFPush.handlePush(userInfo)
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

