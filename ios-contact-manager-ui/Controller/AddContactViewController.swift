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
        
        super.viewDidLoad()
        configureNavigationItem()
        configureTextField()
        textfieldDelegate()
    }
    
    func configureNavigationItem() {
        let dismissButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.title = "새 연락처"
    }
    
    func textfieldDelegate() {
        nameTextField.delegate = self
        ageTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
    
    //키보드 설정 ⭐️
    func configureTextField() {
        let numberPadToolBar = UIToolbar()
        numberPadToolBar.sizeToFit()
        let plusButton = UIBarButtonItem(title: "+ * -", style: .plain, target: self, action: nil)
        numberPadToolBar.items = [plusButton]
        nameTextField.keyboardType = .emailAddress
        ageTextField.keyboardType = .numberPad
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.inputAccessoryView = numberPadToolBar
        phoneNumberTextField.placeholder = "(-)을 포함해서 입력해주세요."
    }
    
    @objc func cancelButtonTapped() {
        presentAlertWithCancel(title: "정말로 취소하시겠습니까?", message: "", confirmTitle: "예", cancelTitle: "아니오") { [weak self] _ in self?.dismissModal() }
    }
    
    func dismissModal() {
        self.dismiss(animated: true)
    }
    
    
    // MARK: - savtButton
    @objc func saveButtonTapped() {
        //        guard let name = nameTextField.text,
        //              let age = ageTextField.text,
        //              let phoneNumber = phoneNumberTextField.text else  { return }
        guard let name = nameTextField.text, !name.isEmpty else { return presentNameAler() }
        guard let age = ageTextField.text, !age.isEmpty else { return presentageAlert() }
        guard let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else { return presentphoneNumberAlert()}
        
        
        
        if !checkAgeTextFeild(age: age) {
            return presentageAlert()
        }
        
        let newContact = Contact(name: name, age: age, phoneNumber: phoneNumber)
        
        
        delegate?.updateContactList(with: newContact)
        
        self.dismiss(animated: true)
    }
    
    //나이유효성 검사
    func checkAgeTextFeild(age: String) -> Bool {
        if let ageNumber = Int(age) {
            return ageNumber > 0 && ageNumber <= 999
        }
        return false
    }
    
    
    
    //⭐️alert정의, protocol 기본정의 해보기?
    func presentNameAler() {
        presentAlert(title: "입력한 이름 정보가 잘못되었습니다.", message: "", confirmTitle: "확인")
    }
    func presentageAlert() {
        presentAlert(title: "입력한 나이 정보가 잘못되었습니다.", message: "", confirmTitle: "확인")
    }
    func presentphoneNumberAlert() {
        presentAlert(title: "입력한 연락처 정보가 잘못되었습니다.", message: "", confirmTitle: "확인")
    }
}

extension AddContactViewController: UITextFieldDelegate {
    
    func removeAllSpace(textFieldText: String) -> String {
        let text = textFieldText.components(separatedBy: .whitespaces)
        let resultText = text.joined()
        return resultText
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let nameText = nameTextField.text,
              let ageText = ageTextField.text,
              let phoneNumberText = phoneNumberTextField.text else { return }
        nameTextField.text = removeAllSpace(textFieldText: nameText)
        ageTextField.text = removeAllSpace(textFieldText: ageText)
        phoneNumberTextField.text = removeAllSpace(textFieldText: phoneNumberText)
        
        print(#function)
    }
    
}





