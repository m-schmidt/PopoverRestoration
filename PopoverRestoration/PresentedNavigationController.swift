import UIKit

class PresentedNavigationController: UINavigationController {

    override func encodeRestorableStateWithCoder(coder: NSCoder) {

        // Call extension to store data for popover restoration
        encodePopoverStateWithCoder(coder)
        super.encodeRestorableStateWithCoder(coder)
    }

    override func decodeRestorableStateWithCoder(coder: NSCoder) {

        // Call extension to restore data for popover restoration (must be done before call to super)
        decodePopoverStateWithCoder(coder)
        super.decodeRestorableStateWithCoder(coder)
    }


    // When the navigation controller appears, update its Done-button
    override func viewWillAppear(animated: Bool) {

        super.viewWillAppear(animated)

        if let presenter = self.presentingViewController {
            updateNavigationItemsForTraits(presenter.traitCollection)
        }
    }

    // Add or remove a Done-button as right navigation item
    func updateNavigationItemsForTraits(traits: UITraitCollection) {

        switch traits.horizontalSizeClass {

        case .Regular:
             self.topViewController?.navigationItem.rightBarButtonItem = nil

        case .Compact:
            let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "dismissNavigationController:")
            self.topViewController?.navigationItem.rightBarButtonItem = doneButton

        default:
            break
        }
    }

    // Handler for Done-button to dismiss the navigation controller
    func dismissNavigationController(sender: AnyObject?) {

        if let presenter = self.presentingViewController {
            presenter.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}

