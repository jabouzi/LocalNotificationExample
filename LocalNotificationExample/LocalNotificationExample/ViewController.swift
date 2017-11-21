//
//  ViewController.swift
//  LocalNotificationExample
//
//  Created by Peter Witham on 3/10/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initNotificationSetupCheck()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initNotificationSetupCheck() {
      if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if success {
                print("success")
            } else {
                print("error")
            }
        }
      } else {
        if(UIApplication.instancesRespond(to: #selector(UIApplication.registerUserNotificationSettings(_:)))) {
          UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
        }
      }
    }
    
    @IBAction func createNotification(_ sender: UIButton) {
      if #available(iOS 10.0, *) {
        let notification = UNMutableNotificationContent()
        notification.title = "Danger Will Robinson"
        notification.subtitle = "Something This Way Comes"
        notification.body = "I need to tell you something, but first read this."
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "notification", content: notification, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
      } else {
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 5) as Date
        notification.alertTitle = "Danger Will Robinson\nSomething This Way Comes"
        notification.alertBody = "I need to tell you something, but first read this."
        notification.timeZone = NSTimeZone.default
        notification.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
        
        UIApplication.shared.scheduleLocalNotification(notification)
      }
    }
}

