//
//  UIViewController+Extension.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit



extension UIViewController {

    class var storyboardID : String {
        return "\(self)"
    }

    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }

    func showAlert(withTitle title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func disableDarkMode(){
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
    }
}

enum AppStoryboard : String {

    case Main, Walkthrough, Auth

    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {

        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }

        return scene
    }

    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

