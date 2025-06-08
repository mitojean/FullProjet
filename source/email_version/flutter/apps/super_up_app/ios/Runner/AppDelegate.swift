import UIKit
import Foundation
import GoogleMaps
import flutter_local_notifications
import CallKit
import AVFAudio
import PushKit
import Flutter
import flutter_callkit_incoming


@main
@objc class AppDelegate: FlutterAppDelegate, PKPushRegistryDelegate, CallkitIncomingAppDelegate {


  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
   GeneratedPluginRegistrant.register(with: self)
   if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    GMSServices.provideAPIKey("AIzaSyAP-yGIutctMXp1XXXXXXXXXXXXXXXXXXX")


    //Setup VOIP
    let mainQueue = DispatchQueue.main
    let voipRegistry: PKPushRegistry = PKPushRegistry(queue: mainQueue)
    voipRegistry.delegate = self
    voipRegistry.desiredPushTypes = [PKPushType.voIP]
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

 // Handle updated push credentials
   func pushRegistry(_ registry: PKPushRegistry, didUpdate credentials: PKPushCredentials, for type: PKPushType) {
       let deviceToken = credentials.token.map { String(format: "%02x", $0) }.joined()
       //Save deviceToken to your server
       SwiftFlutterCallkitIncomingPlugin.sharedInstance?.setDevicePushTokenVoIP(deviceToken)
   }

   func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
       print("didInvalidatePushTokenFor")
       SwiftFlutterCallkitIncomingPlugin.sharedInstance?.setDevicePushTokenVoIP("")
   }

 // Handle incoming pushes
 func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
//     print("didReceiveIncomingPushWith: \(payload.dictionaryPayload)")
     guard type == .voIP else { return }

     let id = payload.dictionaryPayload["session_id"] as? String ?? ""
     let nameCaller = payload.dictionaryPayload["caller_name"] as? String ?? ""
     let handle = payload.dictionaryPayload["handle"] as? String ?? ""
     let callStatus = payload.dictionaryPayload["call_status"] as? String ?? ""
     let is_ending = payload.dictionaryPayload["is_ending"] as!   Bool
     let call_type = payload.dictionaryPayload["call_type"] as? Int ?? 0

     let data = flutter_callkit_incoming.Data(id: id, nameCaller: nameCaller, handle: handle, type: call_type)
//      print(payload.dictionaryPayload)
     // Set extra data
     if let userInfoString = payload.dictionaryPayload["user_info"] as? String,
        let userInfoData = userInfoString.data(using: .utf8),
        let userInfoDict = try? JSONSerialization.jsonObject(with: userInfoData, options: []) as? NSDictionary {
         data.extra = userInfoDict
     } else {
         data.extra = [:]
     }

     if is_ending  == true {
         print("is_ending == true ")
         // End all calls
         SwiftFlutterCallkitIncomingPlugin.sharedInstance?.endAllCalls()
     } else {
         print("is_ending == false")
         // Show incoming call
         SwiftFlutterCallkitIncomingPlugin.sharedInstance?.showCallkitIncoming(data, fromPushKit: true)
     }

     // Make sure to call completion()
     DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
         completion()
     }
 }



       // Call back from Recent history
          override func application(_ application: UIApplication,
                                    continue userActivity: NSUserActivity,
                                    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {

              guard let handleObj = userActivity.handle else {
                  return false
              }

              guard let isVideo = userActivity.isVideo else {
                  return false
              }
              let objData = handleObj.getDecryptHandle()
              let nameCaller = objData["nameCaller"] as? String ?? ""
              let handle = objData["handle"] as? String ?? ""
              let data = flutter_callkit_incoming.Data(id: UUID().uuidString, nameCaller: nameCaller, handle: handle, type: isVideo ? 1 : 0)
              //set more data...
              //data.nameCaller = nameCaller
              SwiftFlutterCallkitIncomingPlugin.sharedInstance?.startCall(data, fromPushKit: true)

              return super.application(application, continue: userActivity, restorationHandler: restorationHandler)
          }

           // Func Call api for Accept
              func onAccept(_ call: Call, _ action: CXAnswerCallAction) {
                  let json = ["action": "ACCEPT", "data": call.data.toJSON()] as [String: Any]
                  print("LOG: onAccept")

              }

              // Func Call API for Decline
              func onDecline(_ call: Call, _ action: CXEndCallAction) {
                  let json = ["action": "DECLINE", "data": call.data.toJSON()] as [String: Any]
                  print("LOG: onDecline")

              }

              // Func Call API for End
              func onEnd(_ call: Call, _ action: CXEndCallAction) {
                  let json = ["action": "END", "data": call.data.toJSON()] as [String: Any]
                  print("LOG: onEnd")

              }

              // Func Call API for TimeOut
              func onTimeOut(_ call: Call) {
                  let json = ["action": "TIMEOUT", "data": call.data.toJSON()] as [String: Any]
                  print("LOG: onTimeOut")

              }

              // Func Callback Toggle Audio Session
              func didActivateAudioSession(_ audioSession: AVAudioSession) {
                  //Use if using WebRTC
                  //RTCAudioSession.sharedInstance().audioSessionDidActivate(audioSession)
                  //RTCAudioSession.sharedInstance().isAudioEnabled = true
              }

              // Func Callback Toggle Audio Session
              func didDeactivateAudioSession(_ audioSession: AVAudioSession) {
                  //Use if using WebRTC
                  //RTCAudioSession.sharedInstance().audioSessionDidDeactivate(audioSession)
                  //RTCAudioSession.sharedInstance().isAudioEnabled = false
              }

}
