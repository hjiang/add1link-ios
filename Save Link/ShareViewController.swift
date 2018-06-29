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

class ShareViewController: SLComposeServiceViewController {

  override func isContentValid() -> Bool {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return true
  }

  override func didSelectPost() {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    if let item = extensionContext?.inputItems.first as? NSExtensionItem {
      if let itemProvider = item.attachments?.first as? NSItemProvider {
        if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
          itemProvider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil, completionHandler: { (url, error) -> Void in
            if let shareURL = url as? NSURL {
              print("***************")
              print(shareURL)
              print("***************")
            }
            self.extensionContext?.completeRequest(returningItems: [], completionHandler:nil)
          })
        }
      }
    }
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    // self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
  }

  override func configurationItems() -> [Any]! {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return []
  }

}
