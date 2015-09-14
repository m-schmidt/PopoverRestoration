import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {

        return true
    }

    func application(application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {

        // Restore when version of saved state matches that of bundle version
        if let stateVersion = coder.decodeObjectForKey(UIApplicationStateRestorationBundleVersionKey)?.integerValue {
            if let bundleVersion = NSBundle.mainBundle().infoDictionary? [kCFBundleVersionKey as String]?.integerValue {

                return stateVersion == bundleVersion
            }
        }

        return false
    }
}
