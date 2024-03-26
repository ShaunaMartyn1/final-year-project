import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyCSLjJEfJxmWWzpUskKbmisYN-gHHPjPl0");//check brackets here - change line with above???
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
