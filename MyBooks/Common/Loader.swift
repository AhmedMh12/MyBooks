//
//  Loader.swift
//  MyBooks
//
//  Created by MacBook Pro on 1/4/2022.
//

import UIKit
import MBProgressHUD

class Loader {
    
    static func showAdded(to view: UIView, animated: Bool){
        MBProgressHUD.showAdded(to: view, animated: animated)
    }
    
    static func hide(for view: UIView, animated: Bool){
        MBProgressHUD.hide(for: view, animated: animated)
    }
}

extension UIViewController {
    
    func showLoader(animated: Bool = false) {
        Loader.showAdded(to: self.view, animated: animated)
    }
    
    func hideLoader(animated: Bool = false) {
        Loader.hide(for: self.view, animated: animated)
    }
}
