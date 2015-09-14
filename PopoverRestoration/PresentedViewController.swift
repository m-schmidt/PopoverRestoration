import UIKit

class PresentedViewController: UIViewController {

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
}



