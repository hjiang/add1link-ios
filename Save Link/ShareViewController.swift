//
//  ShareViewController.swift
//  Save Link
//
//  Created by Hong Jiang on 2018/6/25.
//  Copyright © 2018 1 Byte. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices
import Apollo

class ShareViewController: SLComposeServiceViewController {

  let defaults = UserDefaults(suiteName: "group.link.add1.ios")
  override func isContentValid() -> Bool {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return true
  }

  override func didSelectPost() {
    if let token = defaults?.string(forKey: "token") {
      saveLink(token: token)
    } else {
      let alert = UIAlertController(title: "Not logged in", message: "Please log in at the +1 Link main app.",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
        self.extensionContext!.cancelRequest(
          withError: NSError(domain: "link.add1", code: 0, userInfo: ["reason": "Credentials not found."]))
      }))
      self.present(alert, animated: true, completion: nil)
    }
  }

  func createApolloClient(token: String) -> ApolloClient {
    let configuration = URLSessionConfiguration.default
    // Add additional headers as needed
    configuration.httpAdditionalHeaders = ["Authorization": token] // Replace `<token>`
    let url = URL(string: "https://add1.link/graphql/")!

    return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
  }

  func saveLink(token: String) {
    var hasPendingCallback = false
    if let item = extensionContext?.inputItems.first as? NSExtensionItem {
      if let itemProvider = item.attachments?.first as? NSItemProvider {
        if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
          hasPendingCallback = true
          itemProvider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil, completionHandler: { (url, error) -> Void in
            if let error = error {
              self.extensionContext!.cancelRequest(withError: error)
            } else {
              if let shareURL = url as? NSURL {
                let apollo = self.createApolloClient(token: token)
                apollo.perform(mutation: SaveLinkMutation(url: shareURL.absoluteString!)) {
                  (result, error) in
                  if let error = error {
                    NSLog("Login error: \(error)")
                    self.extensionContext!.cancelRequest(withError: error)
                  } else {
                    self.extensionContext?.completeRequest(returningItems: [], completionHandler:nil)
                  }
                }
              } else {
                self.extensionContext?.completeRequest(returningItems: [], completionHandler:nil)
              }
            }
          })
        }
      }
    }
    if !hasPendingCallback {
      self.extensionContext?.completeRequest(returningItems: [], completionHandler:nil)
    }
  }

  override func configurationItems() -> [Any]! {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return []
  }

}
