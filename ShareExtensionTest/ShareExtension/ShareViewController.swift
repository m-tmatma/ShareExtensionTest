//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by tsuchiyamamasaru on 2016/12/23.
//  Copyright © 2016年 tsuchiyamamasaru. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        
        // http://stackoverflow.com/questions/30824486/ios-share-extension-grabbing-url-in-swift
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            if let attachments = item.attachments as? [NSItemProvider] {
                for attachment: NSItemProvider in attachments {
                    if attachment.hasItemConformingToTypeIdentifier("public.url") {
                        attachment.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (url, error) in
                            if let shareURL = url as? NSURL {
                                // Do stuff with your URL now.
                                print("\(shareURL)")
                            }
                            self.extensionContext?.completeRequest(returningItems: [], completionHandler:nil)
                        })
                    }
                }
            }
        }
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
