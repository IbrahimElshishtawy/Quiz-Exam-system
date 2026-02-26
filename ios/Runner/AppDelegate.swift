import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Observer for screen recording detection
    NotificationCenter.default.addObserver(
        forName: UIScreen.capturedDidChangeNotification,
        object: nil,
        queue: .main
    ) { _ in
        if UIScreen.main.isCaptured {
            // Logic to handle screen recording (e.g., notify Flutter)
        }
    }

    // Observer for screenshot detection
    NotificationCenter.default.addObserver(
        forName: UIApplication.userDidTakeScreenshotNotification,
        object: nil,
        queue: .main
    ) { _ in
        // Logic to handle screenshot
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
