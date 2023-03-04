//
//  InitialViewController.swift
//  AugmentedBook
//
//  Created by andres nowak on 08/03/23.
//

import UIKit

class InitialViewController: UIViewController {
    private var realmManager = RealmManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BookUserManager.shared.initialize()
        
        Task {
            try! await realmManager.initizialize()
        }

        // Do any additional setup after loading the view.
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
