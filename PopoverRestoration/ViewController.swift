import UIKit

class ViewController: UIViewController, PopoverRestorationDelegate {

    // The button that displays the popover
    @IBOutlet weak var showPopoverButton: UIButton!


    // On a segue to the popover define a correct sourceRect to center the popover's anchor
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popoverSegue" {
            if let pc = segue.destinationViewController.presentationController as? UIPopoverPresentationController {
                pc.sourceRect = pc.sourceView!.bounds
                pc.delegate = self
            }
        }
    }


    // MARK: PopoverRestorationDelegate

    func popoverSourceView() -> UIView? {
        return showPopoverButton
    }

    
    // MARK: UIAdaptivePresentationControllerDelegate

    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {

        // Add button to dismiss to navigation controllers in fullscreen
        if style == .FullScreen {
            if let navigationController = controller.presentedViewController as? UINavigationController {
                let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "dismissPresentedController:")
                navigationController.topViewController?.navigationItem.rightBarButtonItem = doneButton
            }
        }

        return nil
    }

    func dismissPresentedController(sender: AnyObject?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
