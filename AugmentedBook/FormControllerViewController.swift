//
//  FormControllerViewController.swift
//  AugmentedBook
//
//  Created by andres nowak on 08/03/23.
//

import UIKit
import RealmSwift

class FormControllerViewController: UIViewController {
    private var realmManager = RealmManager.shared
    
    @IBOutlet weak var AgeOlderThan13Button: UIButton!
    @IBOutlet weak var AgeLessThan13button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.realmManager.subscribe()
        
        self.AgeOlderThan13Button.tag = 1
        self.AgeOlderThan13Button.layer.cornerRadius = 15
        self.AgeOlderThan13Button.layer.masksToBounds = true
        self.AgeOlderThan13Button.addTarget(self, action: #selector(FormButtonClicked),for: .touchUpInside)
        
        self.AgeLessThan13button.tag = 2
        self.AgeLessThan13button.layer.cornerRadius = 15
        self.AgeLessThan13button.layer.masksToBounds = true
        self.AgeLessThan13button.addTarget(self, action: #selector(FormButtonClicked),for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func FormButtonClicked(sender: UIButton) {
        
        let bookUser = BookUserManager.shared.bookUser!
        
        switch sender.tag {
        case 1:
            print("HELL>LLLLO 1")
            bookUser.olderThan13 = true
            break
        case 2:
            print("HELL>LLLLO 2")
            bookUser.olderThan13 = false
            break
        default:
            break
        }
        
//        do {
//            let realm = realmManager.realm!
//
//            print("realm")
//            realm.beginWrite()
//            realm.add(bookUser, update: .all)
//            try realm.commitWrite()
//            print("realm 2")
//        } catch {
//            assertionFailure("\(error)")
//        }
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
