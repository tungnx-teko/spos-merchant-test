//
//  AppDelegate.swift
//  SPOS Merchant
//
//  Created by Tung Nguyen on 8/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit
import MinervaCore
import IQKeyboardManagerSwift
import Janus

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        
        let config = JanusConfig(oauthUrl: "https://oauth.stage.tekoapis.net",
                                 identityUrl: "https://identity.stage.tekoapis.net",
                                 clientId: "b631a62cea4e48a180f6a866c9aa7796",
                                 scope: "openid profile om ps catalog ppm us sellers page_builder",
                                 googleAppId: "563692749265-7d1vdgcj20ltdb61torp9n76mmsi2907.apps.googleusercontent.com",
                                 googleAppSecret: nil,
                                 facebookAppId: "125959422141515",
                                 appleBundleId: "xxxx")
        
        Janus.shared.initialize(config: config)
        Janus.shared.application(for: application, didFinishLaunchingWithOptions: launchOptions)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ScanVC())
        window?.makeKeyAndVisible()
        return true
    }


}

