//
//  BookUser.swift
//  AugmentedBook
//
//  Created by andres nowak on 08/03/23.
//

import Foundation
import RealmSwift

class BookUser: Object, Identifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var olderThan13: Bool = false
    @Persisted var buyBook: Bool = false
}
