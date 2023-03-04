//
//  BookUserManager.swift
//  AugmentedBook
//
//  Created by andres nowak on 08/03/23.
//

import Foundation

class BookUserManager: ObservableObject {
    static var shared = BookUserManager()
    @Published var bookUser: BookUser?
    
    func initialize() {
        bookUser = BookUser()
    }
}
