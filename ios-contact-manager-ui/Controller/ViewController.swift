//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 권태호 on 03/01/2024.
//

import UIKit

class ViewController: UIViewController {
    
    // 데이터를 외부에서 주입할 수 있도록 의존성 주입을 구현해보자.
    var contactList: [Contact] = [
        Contact(name: "Harry", age: 20, phoneNumber: "010-1234-5678"),
        Contact(name: "Hoi", age: 20, phoneNumber: "010-0000-0000"),
        Contact(name: "Dio", age: 20, phoneNumber: "010-1111-1111")
    ]
    
    // 서브 클래싱을 활용하여서 관리해보자
    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var editDoneButton: UIButton!
    
    // 데이터를 외부에서 주입할 수 있도록 의존성 주입을 구현해보자.
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.addMockContactDataList()
    }
    
    // 함수로 위임 받는 부분 적용할 것
    func configureTableView() {
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
    }
    
    func addMockContactDataList() {
        print("연락처가 추가 되었습니다.")
        for _ in 0..<10 {
            self.contactList.append(Contact(name: "목업", age: 100, phoneNumber: "010-9999-9999"))
        }
    }
    
    //cell이 추가될 때 하단으로 스크롤하여 추가된 셀을 보여주기 위함
    //이해가 많이 필요한 코드다
    func scrollToBottom() {
        let lastRowOfIndexPath = self.contactTableView.numberOfRows(inSection: 0) - 1
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: lastRowOfIndexPath, section: 0)
            self.contactTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    @IBAction func deleteTableCell(_ sender: UIButton) {
        //현재 테이블뷰 모드의 편집 모드 상태에 따라 버튼과 편집 모드를 설정해준다.
        if self.contactTableView.isEditing {
            // .normal은 무엇인가?
            self.editDoneButton.setTitle("delete", for: .normal)
            // setEditing 메서드를 통해서 테이블뷰 편집 모드를 설정해준다.
            self.contactTableView.setEditing(false, animated: true)
        } else {
            self.editDoneButton.setTitle("Done", for: .normal)
            self.contactTableView.setEditing(true, animated: true)
        }
    }
    
    //EditingStyle none, delete, insert
    
    @IBAction func addItem(_ sender: UIButton) {
        let alert = UIAlertController(title: "목업 연락처 추가", message: "확인을 누르면 목업 데이터가 추가됩니다.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            //확인이 눌릴 때 동작
            //⭐️ 실질적으로 셀이 추가되는 로직
            self.contactList.append(Contact(name: "추가된 목업", age: 100, phoneNumber: "010-9999-9999"))
            //⭐️
            
            //셀이 추가되고 테이블 뷰를 다시 그려준다.
            self.contactTableView.reloadData()
            //셀이 추가되었을 때 하단에 추가된 셀 위치로 스크롤
            self.scrollToBottom()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editTableCell(_ sender: UIButton) {
        let alert = UIAlertController(title: "입력한 번호의 셀을 목업 연락처로 변경", message: "확인을 누르면 수정됩니다.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "수정할 셀 번호"
        }
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            let accessIndex: Int
            guard let text = alert.textFields?[0].text else { return }
            guard let index = Int(text) else {
                return
            }
            if index <= 0 {
                return
            } else {
                accessIndex = index - 1
            }
            //확인이 눌릴 때 동작
            //⭐️ 실질적으로 셀이 수정되는 로직
            self.contactList[accessIndex] = Contact(name: "추가된 목업", age: 100, phoneNumber: "010-9999-9999")
            //⭐️
            
            //셀이 추가되고 테이블 뷰를 다시 그려준다.
            self.contactTableView.reloadData()
            //셀이 추가되었을 때 하단에 추가된 셀 위치로 스크롤
            self.scrollToBottom()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = contactTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String("\(contactList[indexPath.row].name)" + "(\(contactList[indexPath.row].age))")
        cell.detailTextLabel?.text = contactList[indexPath.row].phoneNumber
        return cell
    }
    
    //Edit Mode에서 Row별 모드 지정
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == 0 {
            return .insert
        } else {
            return .delete
        }
    }
    
    //Edit Mode의 +, - 버튼
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            print("\(indexPath.row)번의 셀을 삭제합니다.")
            self.contactList.remove(at: indexPath.row)
            contactTableView.deleteRows(at: [indexPath], with: .automatic)
        } else {
            print("insert")
            self.contactList.insert(self.contactList[indexPath.row], at: indexPath.row + 1)
            contactTableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ViewController: UITableViewDelegate {
    //Row의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

