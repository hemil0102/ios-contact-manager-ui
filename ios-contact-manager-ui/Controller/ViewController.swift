//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 권태호 on 03/01/2024.
//

import UIKit

class ViewController: UIViewController {
    
    var contactList: [Contact] = []
    
    var mockData: [Contact] = [ Contact(name: "목업", age: 99, phoneNumber: "010-9999-9999") ]
    
    var numberOfLastRow: Int {
        contactTableView.numberOfRows(inSection: 0)
    }
    
    @IBOutlet weak var contactTableView: UITableView!

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
        loadData()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addMockData()
        scrollToBottom()
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        if self.contactTableView.isEditing {
            self.deleteButton.setTitle("Delete", for: .normal)
            self.contactTableView.setEditing(false, animated: true)
        } else {
            self.deleteButton.setTitle("Done", for: .normal)
            self.contactTableView.setEditing(true, animated: true)
        }
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
       presentAlertWithTextfieldAndCancel(title: "입력한 번호의 셀을 목업으로 수정합니다.",
                                          message: "확인을 누르면 수정됩니다.",
                                          placeholder: "수정할 셀 번호",
                                          confirmTitle: "확인",
                                          cancelTitle: "취소") { [weak self] enteredText in
           self?.modifyTableCell(of: enteredText)
       }
    }
    
    func loadData() {
        guard let filePath = Bundle.main.path(forResource: "mockJson", ofType: "json") else { return }
        let decoder = JSONDecoder()
        var content: String = ""
        
        do {
            content = try String(contentsOfFile: filePath)
        } catch {
            print("Error")
        }
        
        let data = content.data(using: .utf8)
        
        do {
            contactList = try decoder.decode(Array<Contact>.self, from: data!)
        } catch {
            print("Error")
        }
    }
    
    func modifyTableCell(of selectedCell: String) {
        guard let selectedCellNumber = Int(selectedCell) else { return }
        let selectedCellIndex: Int
        if selectedCellNumber <= 0 || selectedCellNumber > numberOfLastRow {
            return
        } else {
            selectedCellIndex = selectedCellNumber - 1
        }
        contactList[selectedCellIndex] = mockData[0]
        contactTableView.reloadRows(at: [IndexPath(row: selectedCellIndex, section: 0)], with: .fade)
        scrollToBottom()
    }
            
    func addMockData() {
        contactList.append(mockData[0])
        self.contactTableView.reloadData()
    }
    
    func scrollToBottom() {
        let lastRowOfIndexPath = numberOfLastRow - 1
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: lastRowOfIndexPath, section: 0)
            self.contactTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = contactTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String("\(contactList[indexPath.row].name)" + "(\(contactList[indexPath.row].age))")
        cell.detailTextLabel?.text = contactList[indexPath.row].phoneNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.contactList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

