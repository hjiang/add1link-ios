//
//  ViewController.swift
//  Add 1 Link
//
//  Created by Hong Jiang on 2018/6/25.
//  Copyright © 2018 1 Byte. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  var authenticatedEmail: String?
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func loginPressed(_ sender: Any) {
    let email = emailField.text!
    let password = passwordField.text!
    GlobalInstances.apolloClient.perform(mutation: LoginMutation(email: email, password: password)) {
      (result, error) in
      if let error = error {
        NSLog("Login error: \(error)")
      } else {
        self.authenticatedEmail = result?.data?.login?.user?.email
        self.performSegue(withIdentifier: "showLinksAfterLogin", sender: self)
      }
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "showLinksAfterLogin") {
      let linksViewController = segue.destination as! LinksViewController
      linksViewController.authenticatedEmail = authenticatedEmail
    }
  }

}

