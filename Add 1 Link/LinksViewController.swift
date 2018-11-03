//
//  LinksViewController.swift
//  Add 1 Link
//
//  Created by Hong Jiang on 2018/6/29.
//  Copyright © 2018 1 Byte. All rights reserved.
//

import UIKit

class LinksViewController: UIViewController {
  var authenticatedEmail: String?
  var defaults: UserDefaults? = nil

  @IBOutlet weak var debugLabel: UILabel!


  override func viewDidLoad() {
    super.viewDidLoad()
    debugLabel.text = authenticatedEmail!

        // Do any additional setup after loading the view.

  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  @IBAction func LogoutPressed(_ sender: Any) {
    defaults?.removeObject(forKey: "token")
    defaults?.removeObject(forKey: "email")
    defaults?.synchronize()
    dismiss(animated: true, completion: nil)
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
