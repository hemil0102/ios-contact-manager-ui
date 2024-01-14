//
//  ContactManager.swift
//  ios-contact-manager-ui
//
//  Created by 권태호 on 14/01/2024.
//

import Foundation

//왜 필요함?


final class ContactManager {
    
    lazy var contactList: [Contact] = []
    
     func addContact(contact: Contact) {
        contactList.append(contact)
    }
    
     func removeContactList(index: IndexPath) {
        contactList.remove(at: index.row)
    }
    
     func showDetailContactList(index: IndexPath) {
        //연락처 세부사항 가기 로직 넣을 예정
    }
}


