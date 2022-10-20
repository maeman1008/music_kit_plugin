import Flutter
import UIKit
import StoreKit
import MusicKit

enum AuthorizationError: String {
    case restricted = "RESTRECTED"
    case notDetermined = "NOT_DETERMINED"
    case denied = "DENIED"
}

enum Method: String {
    case requestPermission
    case getUserToken
    case getDefaultDeveloperToken
}

public class SwiftMusicKitPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "music_kit_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftMusicKitPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      guard let method = Method(rawValue: call.method) else {
          result(FlutterMethodNotImplemented)
          return
      }
      switch method {
      case .requestPermission:
          requestAuthorization(result: result)
      case .getDefaultDeveloperToken:
          getDefaultDeveloperToken(result: result)
      case .getUserToken:
          getUserToken(developerToken: call.arguments as! String, result: result)
      }
  }
    
    public func getDefaultDeveloperToken(result: @escaping FlutterResult) {
        Task {
          do {
            let token = try await DefaultMusicTokenProvider().developerToken(options: MusicTokenRequestOptions.ignoreCache)
            result(token)
          } catch {
            result(nil)
          }
        }

    }
    
    public func requestAuthorization(result: @escaping FlutterResult) {
        SKCloudServiceController.requestAuthorization() { status in
            switch status {
            case .authorized:
                result("AUTHORIZED")
            case .restricted:
                result(FlutterError(code: AuthorizationError.restricted.rawValue, message: nil, details: nil))
            case .notDetermined:
                result(FlutterError(code: AuthorizationError.notDetermined.rawValue, message: nil, details: nil))
            case .denied:
                result(FlutterError(code: AuthorizationError.denied.rawValue, message: nil, details: nil))
            @unknown default:
                result(FlutterError(code: AuthorizationError.notDetermined.rawValue, message: nil, details: nil))
            }
        }
    }
    
    public func getUserToken(developerToken: String, result: @escaping FlutterResult) {
        SKCloudServiceController().requestUserToken(forDeveloperToken: developerToken) { (userToken, error) in
            if let error = error {
                result(FlutterError(code: "UNAVAILABLE", message: "Error Encountered", details: error))
                return
            }
            result(userToken)
        }
    }
}
