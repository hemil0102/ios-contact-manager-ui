//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 권태호 on 03/01/2024.
//

import UIKit

final class ContactListViewController: UIViewController {
    
    var delegate:AddContactViewControllerDelegate?
    
    //MARK: - Properties
    var contactList: [Contact] = []
    private var mockData: [Contact] = [ Contact(name: "목업", age: "99", phoneNumber: "010-9999-9999") ]
    private var numberOfLastRow: Int {
        contactTableView.numberOfRows(inSection: 0)
    }
    
    //MARK: - @IBOutlet
    @IBOutlet private weak var contactTableView: UITableView!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var editButton: UIButton!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureTableView()
        configureNavigationItem()
        
    }
    
    //MARK: - @IBAction
    @IBAction private func addButtonTapped(_ sender: UIButton) {
        addMockData()
        scrollToBottom()
    }
    
    @IBAction private func deleteButtonTapped(_ sender: UIButton) {
        if self.contactTableView.isEditing {
            self.deleteButton.setTitle("Delete", for: .normal)
            self.contactTableView.setEditing(false, animated: true)
        } else {
            self.deleteButton.setTitle("Done", for: .normal)
            self.contactTableView.setEditing(true, animated: true)
        }
    }
    
    @IBAction private func editButtonTapped(_ sender: UIButton) {
        presentAlertWithTextfieldAndCancel(title: "입력한 번호의 셀을 목업으로 수정합니다.",
                                           message: "확인을 누르면 수정됩니다.",
                                           placeholder: "수정할 셀 번호",
                                           confirmTitle: "확인",
                                           cancelTitle: "취소") { [weak self] enteredText in
            self?.modifyTableCell(of: enteredText)
        }
    }
    
    //MARK: - Custom Methods
    
    private func configureNavigationItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactButtonTapped(_:)))
    }
    
    @objc func addContactButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "modal") as? AddContactViewController else { return }
        
        nextViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: nextViewController)
        
        navigationController.modalPresentationStyle = .popover
        self.present(navigationController, animated: true)
    }
    
    private func configureTableView() {
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
    }
    
    private func addMockData() {
        contactList.append(mockData[0])
        self.contactTableView.insertRows(at: [IndexPath(row: numberOfLastRow, section: 0)], with: .automatic)
    }
    
    private func scrollToBottom() {
        let lastRowOfIndexPath: Int?
        
        if numberOfLastRow <= 0 {
            lastRowOfIndexPath = NSNotFound
        } else {
            lastRowOfIndexPath = numberOfLastRow - 1
        }
        
        guard let lastRow = lastRowOfIndexPath else { return }
        
        if lastRow != NSNotFound {
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: lastRow, section: 0)
                self.contactTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        } else {
            print("indexPath가 유효하지 않습니다.")
        }
    }
    
    private func loadData() {
        do {
            contactList = try JsonDecoder<[Contact]>().loadData(from: "mockJson", of: "json")
        } catch {
            print("loadData() 에러가 발생했습니다.")
        }
    }
    
    private func modifyTableCell(of selectedCell: String) {
        guard let selectedCellNumber = Int(selectedCell) else { return }
        let selectedCellIndex: Int
        guard selectedCellNumber >= 0 && selectedCellNumber < numberOfLastRow else { return }
        selectedCellIndex = selectedCellNumber - 1
        contactList[selectedCellIndex] = mockData[0]
        contactTableView.reloadRows(at: [IndexPath(row: selectedCellIndex, section: 0)], with: .fade)
        scrollToBottom()
    }
}

//MARK: - UITableViewDataSource Extension
extension ContactListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = contactTableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath)
        cell.textLabel?.text = String("\(contactList[indexPath.row].name)" + "(\(contactList[indexPath.row].age))")
        cell.detailTextLabel?.text = contactList[indexPath.row].phoneNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.contactList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

//MARK: - UITableViewDelegate Extension
extension ContactListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

extension ContactListViewController:AddContactViewControllerDelegate {
    
    func updateContactList(with contact: Contact) {
        contactList.append(contact)
        self.contactTableView.insertRows(at: [IndexPath(row: numberOfLastRow, section: 0)], with: .automatic)
    }
}


