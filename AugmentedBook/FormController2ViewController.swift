//
//  FormController2ViewController.swift
//  AugmentedBook
//
//  Created by andres nowak on 08/03/23.
//

import UIKit
import RealmSwift

class FormController2ViewController: UIViewController {
    private var realmManager = RealmManager.shared
    
    @IBOutlet weak var BuyBookYesButton: UIButton!
    @IBOutlet weak var BuyBookNoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.realmManager.subscribe()
        
        self.BuyBookYesButton.tag = 1
        self.BuyBookYesButton.layer.cornerRadius = 15
        self.BuyBookYesButton.layer.masksToBounds = true
        self.BuyBookYesButton.addTarget(self, action: #selector(FormButtonClicked),for: .touchUpInside)
        
        self.BuyBookNoButton.tag = 2
        self.BuyBookNoButton.layer.cornerRadius = 15
        self.BuyBookNoButton.layer.masksToBounds = true
        self.BuyBookNoButton.addTarget(self, action: #selector(FormButtonClicked),for: .touchUpInside)
    }
    
    @objc func FormButtonClicked(sender: UIButton) {
        
        let bookUser = BookUserManager.shared.bookUser!
        
        switch sender.tag {
        case 1:
            print("HELL>LLLLO 1")
            bookUser.buyBook = true
            break
        case 2:
            print("HELL>LLLLO 2")
            bookUser.buyBook = false
            break
        default:
            break
        }
        
        do {
            let realm = realmManager.realm!
            
            print("realm")
            realm.beginWrite()
            realm.add(bookUser, update: .all)
            try realm.commitWrite()
            print("realm 2")
        } catch {
            assertionFailure("BRealm Error")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
