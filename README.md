# PopoverRestoration
A demo project for iOS state restoration with view controllers presented through UIPopoverPresentationControllers.

The presented view controllers adapt to changes of the size class, i.e. when switching between comptact and regular the presentation style changes to popover or fullscreen presentation accordingly. In compact/fullscreen mode a "Done" button is added dynamically to allow the dismissal of the presented view controller.

The presented view controller completely saves its state, such that state restoration works in all situations.

The project is tested with iOS 10.0.