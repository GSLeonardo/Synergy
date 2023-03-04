//
//  RealmManager.swift
//  AugmentedBook
//
//  Created by andres nowak on 08/03/23.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    let app: App
    
    @Published var realm: Realm?
    static let shared = RealmManager()
    @Published var user: User?
    @Published var configuration: Realm.Configuration?
    
    private init() {
        let app_id = loadAppConfig()
        self.app = App(id: app_id)
    }
    
    @MainActor
    func initizialize() async throws {
        // authentication
        
        user = try await app.login(credentials: Credentials.anonymous)
        
        self.configuration = user?.flexibleSyncConfiguration(initialSubscriptions: {subs in
            if let _ = subs.first(named: "send-user") {
                return
            } else {
                subs.append(QuerySubscription<BookUser>(name: "send-user"))
            }
        }, rerunOnOpen: false)
        
        realm = try! await Realm(configuration: configuration!, downloadBeforeOpen: .never)
    }
    
    func subscribe() {
        let subscriptions = realm?.subscriptions
        
        if subscriptions?.first(named: "send-user") == nil {
            subscriptions?.update {
                subscriptions?.append(QuerySubscription<BookUser>(name: "send-user"))
            }
        }
    }
}
