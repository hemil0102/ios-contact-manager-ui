//
//  AddContanctViewController.swift
//  ios-contact-manager-ui
//
//  Created by Harry Ho on 1/10/24.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func updateContactList(with contact: Contact)
}

class AddContactViewController: UIViewController {
    
    var addedContactList: [Contact] = []
    weak var delegate: SendDataDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureTextField()
        
    }
    
    func configureTextField() {
        nameTextField.keyboardType = .emailAddress
        ageTextField.keyboardType = .numberPad
        phoneNumberTextField.keyboardType = .numbersAndPunctuation
    }
    
    func removeEmptySpaceCharacter(_ textField: UITextField) -> String? {
        return textField.text?.filter { !$0.isWhitespace }
    }
    
    func configureNavigationItem() {
        let dismissButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.title = "새 연락처"
    }
    
    @objc func cancelButtonTapped() {
        presentAlertWithCancel(title: "정말로 취소하시겠습니까?", message: "", confirmTitle: "예", cancelTitle: "아니오") { [weak self] _ in self?.dismissModal() }
    }
    
    func dismissModal() {
        self.dismiss(animated: true)
    }
    
    // MARK: - saveButton
    @objc func saveButtonTapped() {
        guard let name = removeEmptySpaceCharacter(nameTextField), !name.isEmpty else { return presentNameAlert() }
        guard let age = removeEmptySpaceCharacter(ageTextField), !age.isEmpty else { return presentAgeAlert() }
        guard var phoneNumber = phoneNumberTextField.text else { return }
        
        checkAgeTextField(age: age)
        
        phoneNumber = formatPhoneNumber(phoneNumber)
        guard !phoneNumber.isEmpty else { return presentPhoneNumberAlert() }
        phoneNumberTextField.text = phoneNumber
        
        let newContact = Contact(name: name, age: age, phoneNumber: phoneNumber)
        delegate?.updateContactList(with: newContact)
        self.dismiss(animated: true)
    }
    
    
    func checkDigitsOver(number: Int, for phoneNumber: String) -> Bool {
        if phoneNumber.count < number {
            return false
        } else {
            return true
        }
    }
    
    
    func formatPhoneNumber(_ number: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "^(0[0-9]{1,2}-?[0-9]{3,4}-?[0-9]{4})$", options: [])
            let matches = regex.matches(in: number, options: [], range: NSRange(location: 0, length: number.utf16.count))
            if let match = matches.first {
                return (number as NSString).substring(with: match.range)
            }
        } catch {
            print("정규식 에러: \(error.localizedDescription)")
        }
        return number
    }
    
    func checkAgeTextField(age: String) {
        guard let ageNumber = Int(age), 0 < ageNumber, ageNumber <= 999 else { return presentAgeAlert() }
    }
    
    //MARK: - Alert 구현
    func presentNameAlert() {
        presentAlert(title: "\(TextFieldError.nameTextFieldError.ErrorMessage)", message: "", confirmTitle: "확인")
    }
    
    func presentAgeAlert() {
        presentAlert(title: "\(TextFieldError.ageTextFieldError.ErrorMessage)", message: "", confirmTitle: "확인")
    }
    
    func presentPhoneNumberAlert() {
        presentAlert(title: "\(TextFieldError.phoneNumberFieldError.ErrorMessage)", message: "", confirmTitle: "확인")
    }
}


extension AddContactViewController:UITextFieldDelegate {
}


