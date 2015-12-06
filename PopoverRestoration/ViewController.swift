import UIKit

class ViewController: UIViewController, PopoverRestorationDelegate {

    // The button that triggers a popver segue
    @IBOutlet weak var showPopoverButton: UIButton!


    // Catch segues to the popover
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "popoverSegue" {

            // Define a correct sourceRect to center the popover's anchor
            if let pc = segue.destinationViewController.presentationController as? UIPopoverPresentationController {
                pc.sourceRect = pc.sourceView!.bounds
                pc.delegate = self
            }

            // Update the Done-button state of a presented navigation controller
            if let nc = segue.destinationViewController as? PresentedNavigationController {
                nc.updateDoneButtonStateForTraits(self.traitCollection);
            }
        }
    }

    // When the traits change, update the Done-button state of a presented navigation controller
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)

        if let nc = presentedViewController as? PresentedNavigationController {
            nc.updateDoneButtonStateForTraits(newCollection);
        }
    }


    // MARK: PopoverRestorationDelegate


    func popoverSourceView() -> UIView? {
        return showPopoverButton
    }
}
