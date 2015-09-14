import UIKit

class ViewController: UIViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        // Define sourceRect to center the popover's anchor
        if segue.identifier == "popoverSegue" {
            if let pc = segue.destinationViewController.presentationController as? UIPopoverPresentationController {
                pc.sourceRect = pc.sourceView!.bounds
            }
        }
    }

    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
    }
}
