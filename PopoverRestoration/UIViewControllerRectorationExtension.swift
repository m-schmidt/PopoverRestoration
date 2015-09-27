//
//  UIViewControllerRectorationExtension.swift
//

import UIKit


// Protocol for view controllers that want to present restorable popovers
protocol PopoverRestorationDelegate : UIPopoverPresentationControllerDelegate {

    // The source view and rectangle that presents the popover
    func popoverSourceView() -> UIView?
    func popoverSourceRect() -> CGRect

    // Allowed arrow directions for the popover
    func popoverArrowDirection() -> UIPopoverArrowDirection
}


// Default implementations
extension PopoverRestorationDelegate {

    func popoverSourceRect() -> CGRect {
        return popoverSourceView()?.bounds ?? CGRectZero
    }

    func popoverArrowDirection() -> UIPopoverArrowDirection {
        return .Any
    }
}


// Keys for encoding of popoverPresentationController's configuration
private let keySourceViewController = "popoverRestorationSourceViewController"
private let keySourceView = "popoverRestorationSourceView"
private let keySourceRect = "popoverRestorationSourceRect"
private let keyArrowDirections = "popoverRestorationPermittedArrowDirections"


extension UIViewController {

    func encodePopoverStateWithCoder(coder: NSCoder) {

        if let pc = presentingViewController as? PopoverRestorationDelegate {
            if let sourceView = pc.popoverSourceView() {

                // Store a reference to the presenting view controller
                coder.encodeObject(presentingViewController, forKey:keySourceViewController)

                // Store configuration of the popoverPresentationController
                coder.encodeObject(sourceView, forKey:keySourceView)
                coder.encodeObject(NSValue(CGRect: pc.popoverSourceRect()), forKey:keySourceRect)
                coder.encodeInteger(Int(pc.popoverArrowDirection().rawValue), forKey:keyArrowDirections)
            }
        }
    }


    func decodePopoverStateWithCoder(coder: NSCoder) {

        if let sourceViewController = coder.decodeObjectForKey(keySourceViewController) as? PopoverRestorationDelegate {
            if let sourceView = sourceViewController.popoverSourceView() {

                // Original style as from storyboard
                let originalModalPresentationStyle = modalPresentationStyle

                // Switch to popover-style and access presentationController to trigger creation of a UIPopoverPresentationController
                modalPresentationStyle = .Popover

                if let pc = presentationController as? UIPopoverPresentationController {

                    // Restore configuration for popoverPresentationController
                    pc.delegate = sourceViewController
                    pc.sourceView = sourceView
                    pc.sourceRect = sourceViewController.popoverSourceRect()
                    pc.permittedArrowDirections = sourceViewController.popoverArrowDirection()

                    // Enforce layout to place sourceView at correct location
                    if let svc = sourceViewController as? UIViewController {
                        svc.view.layoutIfNeeded()
                    }
                }

                // Revert to original style
                modalPresentationStyle = originalModalPresentationStyle
            }
        }
    }
}
