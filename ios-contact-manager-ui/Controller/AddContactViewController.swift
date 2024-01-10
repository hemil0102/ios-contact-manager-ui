//
//  AddContanctViewController.swift
//  ios-contact-manager-ui
//
//  Created by Harry Ho on 1/10/24.
//

import UIKit

protocol AddContactViewControllerDelegate: AnyObject {
    func updateContactList(with contact: Contact)
}

class AddContactViewController: UIViewController {
    
    weak var delegate: AddContactViewControllerDelegate?
    
    var addedContactList: [Contact] = []
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        nameTextField.delegate = self
        ageTextField.delegate = self
        phoneNumberTextField.delegate = self
        super.viewDidLoad()
        configureNavigationItem()
        configureTextField()
    }
    
    func configureNavigationItem() {
        let dismissButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.title = "새 연락처"
    }
    
    //키보드 설정 ⭐️
    func configureTextField() {
        nameTextField.keyboardType = .emailAddress
        ageTextField.keyboardType = .numberPad
        phoneNumberTextField.keyboardType = .emailAddress
    }
    
    @objc func cancelButtonTapped() {
        presentAlertWithCancel(title: "정말로 취소하시겠습니까?", message: "", confirmTitle: "예", cancelTitle: "아니오") { [weak self] _ in self?.dismissModal() }
    }
    
    func dismissModal() {
        self.dismiss(animated: true)
    }
    
    @objc func saveButtonTapped() {
        guard let name = nameTextField.text,
              let age = ageTextField.text,
              let phoneNumber = phoneNumberTextField.text else { return }
        let newContact = Contact(name: name, age: age, phoneNumber: phoneNumber)
        delegate?.updateContactList(with: newContact)
        
        //델리게이트 ⭐️
        self.dismiss(animated: true)
    }
}

extension AddContactViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //숫자 입력이면 false
        if Int(string) != nil {
            return false
        } else {
            guard let text = nameTextField.text else {return true}
            let newLength = text.count - range.length
            return newLength <= 10
        }
    }
}


