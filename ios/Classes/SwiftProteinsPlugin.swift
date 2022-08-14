import Flutter
import UIKit

public class SwiftProteinsPlugin: NSObject, FlutterPlugin {
  public static var registrar:FlutterPluginRegistrar? = nil
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    SwiftProteinsPlugin.registrar = registrar
    let scenekitFactory = FlutterScenekitFactory(messenger: registrar.messenger())
    registrar.register(scenekitFactory, withId: "scenekit")

    let channel = FlutterMethodChannel(name: "proteins", binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(SwiftProteinsPlugin(), channel: channel)
    
    // let instance = SwiftProteinsPlugin()
    // registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "checkConfiguration") {
      result("ok")
    } else {
      result(FlutterMethodNotImplemented)
    }
    result("iOS " + UIDevice.current.systemVersion)
  }
}

class FlutterScenekitFactory :NSObject, FlutterPlatformViewFactory {
  let messenger: FlutterBinaryMessenger

  init(messenger: FlutterBinaryMessenger) {
    self.messenger = messenger
  }

  func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
    let view = FlutterScenekitView(withFrame: frame, viewIdentifier: viewId, messenger: self.messenger)
    return view
  }
}
