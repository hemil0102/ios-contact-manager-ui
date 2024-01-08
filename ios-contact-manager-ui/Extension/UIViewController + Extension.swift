//
//  UIViewController + Extension.swift
//  ios-contact-manager-ui
//
//  Created by Harry Ho on 1/7/24.
//

import UIKit

extension UIViewController {
    
    /// 확인 버튼 하나만 있는 Alert 메서드
    func presentAlert(title: String,
                      message: String,
                      confirmTitle: String,
                      confirmAction: ((UIAlertAction) -> Void)? = nil,
                      completion: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default)
        alertViewController.addAction(confirmAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    /// 확인, 취소 버튼이 있는 Alert 메서드
    func presentAlertWithCancel(title: String,
                                message: String,
                                confirmTitle: String,
                                cancelTitle: String,
                                confirmAction: ((UIAlertAction) -> Void)? = nil,
                                cancelAction: ((UIAlertAction) -> Void)? = nil,
                                completion: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default, handler: confirmAction)
        alertViewController.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: cancelAction)
        alertViewController.addAction(cancelAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    /// 확인, 취소 버튼이 있는 Alert 메서드
    func presentAlertWithTextfieldAndCancel(title: String,
                                message: String,
                                placeholder: String,
                                confirmTitle: String,
                                cancelTitle: String,
                                confirmAction: ((String) -> Void)? = nil,
                                cancelAction: ((UIAlertAction) -> Void)? = nil,
                                completion: (() -> Void)? = nil) {
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertViewController.addTextField { textField in
            textField.placeholder = "\(placeholder)"
        }
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
                if let text = alertViewController.textFields?.first?.text {
                    confirmAction?(text)
            }
        }
        
        alertViewController.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: cancelAction)
        alertViewController.addAction(cancelAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
}



