import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  private var txtToPreventScreenshots = UITextField()
  private var txtIsAlreadySecure = UITextField()

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    //to prevent screenshots
    makeSecure(window);

    //channel for screenshot locker
    let screenshotLockerChannel = FlutterMethodChannel(name: "exampleChannel/screenshot-locker",
                                                binaryMessenger: controller.binaryMessenger)

    //handler for screenshot locker.
    screenshotLockerChannel.setMethodCallHandler({
        [ ](call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        // This method is invoked on the UI thread.
        // Handle screenshot-locker messages.
        switch call.method{
        case "enablescreen":
            self.txtToPreventScreenshots.isSecureTextEntry=false
        case "disablescreen":
            self.txtToPreventScreenshots.isSecureTextEntry=true
        default: result(FlutterMethodNotImplemented)
        }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func makeSecure(_ window: UIWindow) {
          if (!txtIsAlreadySecure.isSecureTextEntry) {
              print("Making window secure")
              txtIsAlreadySecure.isSecureTextEntry=true
              let view = UIView(frame: CGRect(x: 0, y: 0, width: self.txtToPreventScreenshots.frame.self.width, height: self.txtToPreventScreenshots.frame.self.height))

              let image = UIImageView(image: UIImage(named: "whiteImage"))
              image.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

              window.addSubview(self.txtToPreventScreenshots)
              view.addSubview(image)

              window.layer.superlayer?.addSublayer(self.txtToPreventScreenshots.layer)
              self.txtToPreventScreenshots.layer.sublayers?.last!.addSublayer(window.layer)

              self.txtToPreventScreenshots.leftView = view

          }else{
              print("Window is already secure")
          }
  }
}