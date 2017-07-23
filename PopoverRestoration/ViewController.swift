// ViewController.swift

import UIKit


class ViewController: UIViewController, PopoverRestorationDelegate {

    // The button that triggers a popver segue
    @IBOutlet weak var showPopoverButton: UIButton!


    // Catch segues to the popover
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "popoverSegue" {

            // Define a correct sourceRect to center the popover's anchor
            if let pc = segue.destination.presentationController as? UIPopoverPresentationController {
                pc.sourceRect = pc.sourceView!.bounds
                pc.delegate = self
            }

            // Update the Done-button state of a presented navigation controller
            if let nc = segue.destination as? PresentedNavigationController {
                nc.updateNavigationItemsForTraits(self.traitCollection);
            }
        }
    }

    // When the traits change, update the Done-button state of a presented navigation controller
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)

        if let nc = presentedViewController as? PresentedNavigationController {
            nc.updateNavigationItemsForTraits(newCollection);
        }
    }


    // MARK: PopoverRestorationDelegate


    func popoverSourceView() -> UIView? {
        return showPopoverButton
    }
}
