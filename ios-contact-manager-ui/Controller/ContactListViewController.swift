//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 권태호 on 03/01/2024.
//

import UIKit

final class ContactListViewController: UIViewController {
    
    //MARK: - Properties
    private var contactList: [Contact] = []
    var filteredContacts: [Contact] = []
    var searchController = UISearchController(searchResultsController: nil)
    var isSearchActive: Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
    private var numberOfLastRow: Int {
        contactTableView.numberOfRows(inSection: 0)
    }
    
    //MARK: - @IBOutlet
    @IBOutlet private weak var contactTableView: UITableView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureTableView()
        configureNavigationItem()
        configureSearchBar()
    }
    
    //MARK: - Custom Methods
    private func configureNavigationItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactButtonTapped(_:)))
    }
    
    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "연락처 검색"
        navigationItem.searchController = searchController
    }
    
    @objc private func addContactButtonTapped(_ sender: UIButton) {
        guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: AddContactViewController.className) as? AddContactViewController else { return }
        
        nextViewController.delegate = self
        
        let navigationViewController = UINavigationController(rootViewController: nextViewController)
        navigationViewController.modalPresentationStyle = .automatic
        
        self.present(navigationViewController, animated: true)
    }
    
    private func configureTableView() {
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
    }
    
    private func addData(with data: Contact) {
        contactList.append(data)
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
            print("\(JsonParsingError.fileLoadError.errorMessage)")
            print("\(JsonParsingError.fileLoadError.localizedDescription)")
        }
    }
    
    private func modifyTableCell(of selectedCell: String) {
        let selectedCellIndex: Int
        
        guard let selectedCellNumber = Int(selectedCell) else { return }
        
        guard selectedCellNumber >= 0 && selectedCellNumber < numberOfLastRow else { return }
        selectedCellIndex = selectedCellNumber - 1
        
        //contactList[selectedCellIndex] = mockData[0]
        contactTableView.reloadRows(at: [IndexPath(row: selectedCellIndex, section: 0)], with: .fade)
        scrollToBottom()
    }
}


extension ContactListViewController: AddContactDelegate {
    
    func updateContactList(with contact: Contact) {
        addData(with: contact)
    }
}


//MARK: - UITableViewDataSource Extension
extension ContactListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? filteredContacts.count : contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = contactTableView.dequeueReusableCell(withIdentifier: "contactListCell", for: indexPath)
        let contact = isSearchActive ? filteredContacts[indexPath.row] : contactList[indexPath.row]
        
        cell.textLabel?.text = "\(contact.name) (\(contact.age))"
        cell.detailTextLabel?.text = contact.phoneNumber
        
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


// MARK: - searchBar Extension
extension ContactListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            filteredContacts = contactList
            contactTableView.reloadData()
            return
        }
        filteredContacts = contactList.filter { contact in
            return contact.name.lowercased().contains(searchText.lowercased())
        }
        contactTableView.reloadData()
    }
}
