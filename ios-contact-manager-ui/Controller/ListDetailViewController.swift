//
//  ListDetailViewController.swift
//  ios-contact-manager-ui
//
//  Created by 권태호 on 09/01/2024.
//

import UIKit

class ListDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItam()
    }
    
    func setNavigationItam() {
        let dismissButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissModal))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(dismissModal))
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.title = "새 연락처"
    }
    
    @objc func dismissModal() {
        self.dismiss(animated: true)
    }
}
