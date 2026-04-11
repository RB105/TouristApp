import Flutter
import UIKit

@main @objc class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Get FlutterViewController
        guard let flutterViewController = window?.rootViewController as? FlutterViewController else {
            return false

        }

        // Create method channel
        let configChannel = FlutterMethodChannel(
            name: "TouristChannel",
            binaryMessenger: flutterViewController.binaryMessenger
        )

        // Handler
        configChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            switch call.method {
//            case "getKey":
//                let arguments = call.arguments as? [String: Any]
//                let key = arguments?["key"] as? String
//                if let value = self?.getBaseUrl(forKey: key) {
//                    result(value)
//                } else {
//                    result(FlutterError(code: "CONFIG_ERROR",
//                        message: "\(key ?? "Key") not found",
//                        details: nil))
//                }

            case "getVersionName":
                if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                    result(version)
                } else {
                    result(FlutterError(code: "UNAVAILABLE",
                        message: "Version not available",
                        details: nil))
                }

            case "getVersionCode":
                if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                    result(buildNumber)
                } else {
                    result(FlutterError(code: "UNAVAILABLE",
                        message: "Version code not available",
                        details: nil))
                }

            default:
                result(FlutterMethodNotImplemented)
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // Method to retrieve base URL from Info.plist
//    func getBaseUrl(forKey key: String?) -> String? {
//        guard let key = key else { return nil }
//        return Bundle.main.object(forInfoDictionaryKey: key) as? String
//    }
}
