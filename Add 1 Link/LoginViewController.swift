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
  let defaults = UserDefaults(suiteName: "group.link.add1.ios")

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func viewDidAppear(_ animated: Bool) {
    if let _ = defaults?.string(forKey: "token") {
      if let email = defaults?.string(forKey: "email") {
        authenticatedEmail = email
        performSegue(withIdentifier: "showLinksAfterLogin", sender: self)
        
      }
    }
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
        self.passwordField.text = ""
        self.authenticatedEmail = result?.data?.login?.user?.email
        self.defaults?.set(result?.data?.login?.token, forKey: "token")
        self.defaults?.set(self.authenticatedEmail, forKey: "email")
        self.defaults?.synchronize()
        self.performSegue(withIdentifier: "showLinksAfterLogin", sender: self)
      }
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "showLinksAfterLogin") {
      let linksViewController = segue.destination as! LinksViewController
      linksViewController.authenticatedEmail = authenticatedEmail
      linksViewController.defaults = defaults
    }
  }

}

