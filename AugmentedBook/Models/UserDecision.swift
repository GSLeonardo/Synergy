//
//  UserDecision.swift
//  AugmentedBook
//
//  Created by andres nowak on 08/03/23.
//

import Foundation
import RealmSwift

class UserDecision: Object, Identifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var buyBook: Bool = false
}
