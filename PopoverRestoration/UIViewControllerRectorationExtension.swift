//
//  UIViewControllerRectorationExtension.swift
//

import UIKit

private let keySourceViewController = "popoverRestorationSourceViewController"
private let keySourceView = "popoverRestorationSourceView"
private let keySourceRect = "popoverRestorationSourceRect"

extension UIViewController {

    func encodePopoverStateWithCoder(coder: NSCoder) {

        if let pc = presentationController as? UIPopoverPresentationController {
            if let sourceView = pc.sourceView {

                // Store a reference to the presenting view controller
                coder.encodeObject(pc.presentingViewController, forKey:keySourceViewController)

                // Store a reference to the source view and data for source rectangle
                // Note that the sourceView needs a restoration identifier
                assert(sourceView.restorationIdentifier != nil)
                coder.encodeObject(sourceView, forKey:keySourceView)
                coder.encodeObject(NSValue(CGRect: pc.sourceRect), forKey:keySourceRect)
            }
        }
    }

    func decodePopoverStateWithCoder(coder: NSCoder) {

        if let sourceViewController = coder.decodeObjectForKey(keySourceViewController) as? UIViewController {
            if let sourceView = coder.decodeObjectForKey(keySourceView) as? UIView {
                if let sourceRectData = coder.decodeObjectForKey(keySourceRect) as? NSValue {

                    // Original style as from storyboard
                    let originalModalPresentationStyle = modalPresentationStyle

                    // Temporarily switch to popover-style and access presentationController to trigger creation of a UIPopoverPresentationController
                    modalPresentationStyle = .Popover

                    if let pc = presentationController as? UIPopoverPresentationController {

                        // Use content view of presenting controller as sourceView/sourceRect
                        pc.sourceView = sourceView
                        pc.sourceRect = sourceRectData.CGRectValue()

                        // Enforce layout to place sourceView at correct location
                        sourceViewController.view.layoutIfNeeded()
                    }

                    // Revert to original style
                    modalPresentationStyle = originalModalPresentationStyle
                }
            }
        }
    }
}
