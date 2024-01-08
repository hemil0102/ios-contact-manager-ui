//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 권태호 on 03/01/2024.
//

import UIKit

final class ViewController: UIViewController {
    
    // 호이의 함수 방식을 적용
    // MARK: - Properties
    private var contactList: [Contact] = [
        Contact(name: "Harry", age: 20, phoneNumber: "010-1234-5678"),
        Contact(name: "Hoi", age: 20, phoneNumber: "010-0000-0000"),
        Contact(name: "Dio", age: 20, phoneNumber: "010-1111-1111")
    ]
    
    private var numberOfLastRow: Int {
        return contactTableView.numberOfRows(inSection: 0)
    }
    // MARK: - Interface Builder Properties
    @IBOutlet private weak var contactTableView: UITableView!
    @IBOutlet private weak var editDoneButton: UIButton!
    
    // MARK: - Life Cycle
    // 데이터를 외부에서 주입할 수 있도록 의존성 주입을 구현해보자.
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.addMockContactDataList()
    }
    
    // MARK: - Interface Builder Methods
    @IBAction func editTableViewCellButton(_ sender: UIButton) {
        presentAlertWithTextfieldAndCancel(
            title: "입력한 번호의 셀을 목업 연락처로 변경",
            message: "확인을 누르면 수정됩니다.",
            placeholder: "수정할 셀 번호",
            confirmTitle: "확인",
            cancelTitle: "취소",
            confirmAction: { [weak self] enteredText in self?.modifyTableCell(of: enteredText) })
    }
    
    @IBAction func tableViewEditModeForDeleteButton(_ sender: UIButton) {
        if self.contactTableView.isEditing {
            self.editDoneButton.setTitle("delete", for: .normal)
            self.contactTableView.setEditing(false, animated: false)
        } else {
            self.editDoneButton.setTitle("Done", for: .normal)
            self.contactTableView.setEditing(true, animated: false)
        }
    }
    
    @IBAction func addTableViewCellButton(_ sender: UIButton) {
        presentAlertWithCancel(title: "목업 연락처 추가",
                               message: "확인을 누르면 목업 데이터가 추가됩니다.",
                               confirmTitle: "확인",
                               cancelTitle: "취소",
                               confirmAction: { [weak self] _ in
            self?.addTableCell() })
    }

    //MARK: - Methods
    private func configureTableView() {
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
    }
    
    //Json도입 하면 삭제 가능!
    private func addMockContactDataList() {
        for _ in 0..<10 {
            self.contactList.append(Contact(name: "목업", age: 100, phoneNumber: "010-9999-9999"))
        }
    }
    
    private func scrollToBottom() {
        let lastRowOfIndexPath = numberOfLastRow - 1
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: lastRowOfIndexPath, section: 0)
            print("test: \(indexPath)")
            self.contactTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    private func addTableCell() {
        contactList.insert(Contact(name: "추가된 목업", age: 100, phoneNumber: "010-9999-9999"), at: numberOfLastRow)
        contactTableView.insertRows(at: [IndexPath(row: numberOfLastRow, section: 0)], with: .fade)
        scrollToBottom()
    }
    
    private func modifyTableCell(of selectedCell: String) {
        guard let selectedCellNumber = Int(selectedCell) else { return }
        
        let selectedCellIndex: Int
        
        if selectedCellNumber <= 0 || selectedCellNumber > numberOfLastRow {
            return
        } else {
            selectedCellIndex = selectedCellNumber - 1
        }

        contactList[selectedCellIndex] = Contact(name: "추가된 목업", age: 100, phoneNumber: "010-9999-9999")
        contactTableView.reloadRows(at: [IndexPath(row: selectedCellIndex, section: 0)], with: .fade)
        scrollToBottom()
    }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = contactTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let contact = contactList[indexPath.row]
        
        cell.textLabel?.text = String("\(contact.name)" + "(\(contact.age))")
        cell.detailTextLabel?.text = contact.phoneNumber
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        contactList.remove(at: indexPath.row)
        contactTableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

