//
//  RouteUtil.swift
//  RNApp
//
//  Created by shutters on 2025/4/8.
//

import UIKit

let notificationName = "toSettingPage"

class RouteUtil: NSObject {
  
  @objc class func swiftLoad() {
          // do something
    print("swift load------")
    NotificationCenter.default.addObserver(self, selector: #selector(notificationAction), name: NSNotification.Name(rawValue: notificationName), object: nil)
    }
  
  class private func getCurrentVcFrom(_ rootVc:UIViewController) -> UIViewController{
   var currentVc:UIViewController
   var rootCtr = rootVc
   if(rootCtr.presentedViewController != nil) {
     rootCtr = rootVc.presentedViewController!
   }
   if rootVc.isKind(of:UITabBarController.classForCoder()) {
     currentVc = getCurrentVcFrom((rootVc as! UITabBarController).selectedViewController!)
   }else if rootVc.isKind(of:UINavigationController.classForCoder()){
     currentVc = getCurrentVcFrom((rootVc as! UINavigationController).visibleViewController!)
   }else{
     currentVc = rootCtr
   }
   return currentVc
  }
  
  @objc class private func notificationAction(noti: Notification) {
    
    DispatchQueue.main.async {
      let rootVc = UIApplication.shared.keyWindow?.rootViewController
      let currentVc = getCurrentVcFrom(rootVc!)
      
      let nav = UINavigationController(rootViewController: SettingPage(nibName: nil, bundle: nil))
      currentVc.present(nav, animated: true)
    }
  }
}
