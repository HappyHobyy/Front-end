import UIKit
import Flutter
import NaverThirdPartyLogin

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var result = false

        // 카카오톡 URL 처리
        if url.absoluteString.hasPrefix("kakao") {
            result = super.application(app, open: url, options: options)
        }

        // 네이버 URL 처리
        if !result {
            result = NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options) ?? false
        }

        return result
    }

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}