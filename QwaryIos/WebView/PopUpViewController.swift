////
////  PopUpViewController.swift
////  QwaryIos
////
////  Created by Geek Tech on 16/05/24.
////
//
import Foundation
import UIKit
import WebKit
import JavaScriptCore

 internal class QwaryWebView:NSObject, QwaryInterface, WKScriptMessageHandler {
    
    //static let shared = Qwary()
    var appID = ""
    var QW_SDK_HOOK = "qwSdkHook"

    var webView = WKWebView()
    var alertController: UIAlertController!
    private weak var viewController: UIViewController?
    var rootPathUrl:URL?
    var delegate: Callback?
    
    var isSdkReady = false
    private var sdkReadyQueue: [String] = [String]()
    public override init() {
        super.init()
        self.delegate = self
    }
     //MARK: Functions for Implementation Qwary Interface
     func configure(context: UIViewController, qwSettings: String) {
        self.appID = qwSettings
        self.viewController = context
       
        let screenHeight = UIScreen.main.bounds.height
         _ = screenHeight / 3
        sdkReadyQueue.removeAll()
        // Add your custom view to the action sheet as well as WebView
        let customViewWidth = context.view.frame.width
        let frame = CGRect(x: 0, y: 0, width: customViewWidth - 12, height: 300)
        // Made WKWebView Configuration
        let contentController = WKUserContentController()
  
        let webViewConfiguration = WKWebViewConfiguration()
        let webpagePreferences = WKWebpagePreferences()
         if #available(iOS 14.0, *) {
             webpagePreferences.allowsContentJavaScript = true
         } else {
             // Fallback on earlier versions
             
         }
        
        webViewConfiguration.defaultWebpagePreferences = webpagePreferences
        
        webViewConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = true
        webViewConfiguration.userContentController = contentController
        webView = WKWebView(frame: frame,configuration: webViewConfiguration)
        webView.navigationDelegate = self
        webView.configuration.userContentController.add(self, name: QW_SDK_HOOK)
        //webView.configuration.userContentController.add(CallBackInterface(delegate: self), name: QW_SDK_HOOK)
        let srcroot = URL(fileURLWithPath: #file).deletingLastPathComponent()
            .deletingLastPathComponent()
        rootPathUrl = URL(string: "\(srcroot)render.html")!
         if #available(iOS 14.0, *) {
             webView.configuration.defaultWebpagePreferences.allowsContentJavaScript  = true
         } else {
             // Fallback on earlier versions
         }

        let url = URL(string: "\(srcroot)render.html")!
         webView.loadFileURL(url, allowingReadAccessTo: url)
         
//        alertController = UIAlertController(title: "Custom", message: nil, preferredStyle: .actionSheet)
//        alertController.view.addSubview(webView)
//        // Present the Action Sheet
//        context.present(alertController, animated:
         
        
        
    }
   
     public func presentSurvey(fragmentActivity: UIViewController, isBanner: Bool) {
        if !isSdkReady{
            print("Sdk Is not ready Yet")
            return
        }else{
            AlertHelper.shared.showAlert(on: viewController!, title: "", message: "", shouldShowWebView: true, web: webView)
        }
       
    }
    
    public func addEvent(eventName: String) {
        sdkReadyQueue.append(getEventTrackScript(eventName: eventName))
    }
    
    public func logout() {
        executeJavascript(getLogoutScript())
        //alertController.dismiss(animated: true)
    }
    
    public func dismissActiveSurvey() {
        print("Dismiss Active survey Called")
    }

    //Get the files
     private func readFileByBundleIF(bundleIF:String,name: String, type: String) -> String {
        //Get The exact root path of file
        var filePath = ""
        if let sdkBundle = Bundle(identifier: bundleIF) {
                    if let path = sdkBundle.path(forResource: name, ofType: type) {
                        print("File path:== \(path)")
                     filePath = path
                        return filePath
                    } else {
                        filePath = "\(name) file of \(type) found in SDK bundle"
                        return filePath
                    }
                } else {
                  
                    filePath = "\(bundleIF) not found in Application"
                    return filePath
                }
            
        }
    func executeJavascript(_ javascript: String, callback: ((String?) -> Void)? = nil) {
        print("executeJavascript: \(javascript)")
        webView.evaluateJavaScript(javascript) { (result, error) in
            if let error = error {
                print("Error executing JavaScript: \(error.localizedDescription)")
                callback?(nil)
            } else if let result = result as? String {
                print("JavaScript execution result: \(result)")
                
                callback?(result)
            } else {
                // Handle other result types if needed
                print("JavaScript Call back nil")
                callback?(nil)
            }
        }
    }
    //Override Method gor WKscriptMessage Handler
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        print("ReceivedMessageBody \(message.body)")
//        print("Received Message Name \(message.name)")
        //print("Received MessageBody \(message.body)")
        if let messageBody = message.body as? [String: Any]{
            print("message Body: \(messageBody)")
        }
//        if message.name == QW_SDK_HOOK{
//            print("Hook Tracked")
//        }
        if let dict = message.body as? [String:Any] {
            print("Returns from Dictionary cast \(dict)")
            return
        }
        guard let data = message.body as? String else {
            print("Returns from string cast")
            return
        }
        print("Continuess")
        print("data received \(data) with-- \(message.name) & Body --\(message.body)")
        switch data {
        case "qwMobileSdkReady":
            delegate?.qwMobileSdkReady(data:data )
        case "qwSurveyHeight":
                delegate?.qwSurveyHeight(data: data)
//        case "qwShow":
//            print("Full Body \(message.body)")
//            if let body = message.body as? [String:Any] {
//                if let name = body["name"], let isTrue = body["isBanner"]{
//                    print("qwShow is tracked")
//                    delegate?.qwShow(data: name as! String, isBanner: isTrue as! Bool)
//                }
//               
//            }
        case "qwShow":
            delegate?.qwShow(data: data, isBanner: false)
        case "qwEventTracking":
                delegate?.qwEventTracking(data: data)
        case "qwMobileLogout":
                delegate?.qwMobileLogout(data: data)
        case "qwDismissSurvey":
                delegate?.qwDismissSurvey(data: data)
        case "CLOSE":
            AlertHelper.shared.dismissAlert()
        case "SURVEY_COMPLETED":
            AlertHelper.shared.dismissAlert()
            
        default:
            break
        }
        
    }
    
    
}
//MARK: Content Handler CallBacks from Qwary Web View
extension QwaryWebView:Callback{
    
    func qwMobileSdkReady(data: String) {
        print("From call back qwMobileSdkReady is called")
        isSdkReady = true
        while !sdkReadyQueue.isEmpty {
            print("data in sdkreadyQueue \(sdkReadyQueue),,,\(data)")
            if let script = sdkReadyQueue.poll() {
                executeJavascript(script)
            }
        }
    }
    
    func qwSurveyHeight(data: String) {
        print("Survey Height \(data)")
    }
    
    func qwShow(data: String, isBanner: Bool) {
        print("Call Back qwShow Func is called & alert Presented")
        AlertHelper.shared.showAlert(on: viewController!, title: "", message: "", shouldShowWebView: true,web:webView)
        
    }
    func qwEventTracking(data: String) {
        print("Event Ttacking CallBack Function is Called")
    }
    func qwMobileLogout(data: String) {
        print("Logout Call Back Func Is Called \(data)")
    }
    
    func qwDismissSurvey(data: String) {
        if alertController.isBeingPresented == true{
            print("Alert Controller is dismissed")
            alertController.dismiss(animated: true)
        }
    }
    
    
}

extension QwaryWebView: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      
        print("Did Finish Calls")
        //injectJavaScript()
        executeJavascript()
      
    }
    
    

    public func injectJavaScript(){
        let script = getInitScript(appId: appID)
        print("Sript \(script)")
        webView.evaluateJavaScript(script) { (result, error) in
            if let error = error {
                print("Error injecting JavaScript: \(error)")
            } else {
                print("JavaScript injected successfully \(String(describing: result))")
                
            }
        }
    }
    func executeJavascript(callback: ((String?) -> Void)? = nil) {
        let javascript = getInitScript(appId: appID)
//        print("executeJavascript: \(javascript)")
//        let jweb = JSContext()
//        jweb?.evaluateScript("var console = { log: function(message) { _consoleLog(message) } }")
//         let consoleLog: @convention(block) (String) -> Void = { message in
//             print("console.log: " + message)
//         }
//        let logHandler: @convention(block) (String) -> Void = { string in
//            print(string)
//        }
//        jweb.
//        jweb?.setObject(unsafeBitCast(consoleLog, to: AnyObject.self), forKeyedSubscript: "_consoleLog" as (NSCopying & NSObjectProtocol)?)
        webView.evaluateJavaScript(javascript) { result, error in
            if let error = error {
                print("JavaScript execution error: \(error)")
                callback?(nil)
                return
            }
            if let resultString = result as? String {
                print("Result String \(resultString)")
                callback?(resultString)
            } else {
                callback?(nil)
            }
        }
    }

    
}

    
//
//class CallBackInterface: NSObject, WKScriptMessageHandler {
//     var delegate: Callback?
//
//    init(delegate: Callback) {
//        self.delegate = delegate
//    }
//
//    // Method to handle incoming messages from JavaScript
//    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        print("Received Message \(message)")
//        print("Received MessageBody \(message.body)")
//        print("Received MessageName \(message.name)")
//        guard let body = message.body as? [String: Any], let method = body["method"] as? String else {
//            print("return from parsing the data")
//            return
//        }
//       print("Body Method calls")
//        switch method {
//        case "qwMobileSdkReady":
//            if let data = body["data"] as? String {
//                delegate?.qwMobileSdkReady(data: data)
//            }
//
//        case "qwSurveyHeight":
//            if let data = body["data"] as? String {
//                delegate?.qwSurveyHeight(data: data)
//            }
//
//        case "qwShow":
//            if let data = body["data"] as? String, let isBanner = body["isBanner"] as? Bool {
//                delegate?.qwShow(data: data, isBanner: isBanner)
//            }
//
//        case "qwEventTracking":
//            if let data = body["data"] as? String {
//                delegate?.qwEventTracking(data: data)
//            }
//
//        case "qwMobileLogout":
//            if let data = body["data"] as? String {
//                delegate?.qwMobileLogout(data: data)
//            }
//
//        case "qwDismissSurvey":
//            if let data = body["data"] as? String {
//                delegate?.qwDismissSurvey(data: data)
//            }
//        case "CLOSE":
//            print("Close function called from javascript")
//
//        default:
//            break
//        }
//    }
//    
//}
////
////extension CustomActionSheetController:WKNavigationDelegate{
////    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
////        let appId = "c5e3e8c3-5b12-481d-a4c9-1570bd532860"
////        let script = getInitScript(appId: appId)
////        webView.evaluateJavaScript(script) { (result, error) in
////            if let error = error {
////                print("Error injecting JavaScript: \(error)")
////            } else {
////                print("JavaScript injected successfully")
////            }
////        }
////    }
////    func getInitScript(appId: String) -> String
////  {
////      return """
////      var app_id = "\(appId)";
////      window.qwSettings = {
////        appId: app_id,
////      };
////      !(function () {
////        if (!window.qwTracking) {
////          window.qwTracking = Object.assign({}, window.qwTracking, {
////            queue:
////              window.qwTracking && window.qwTracking.queue
////                ? window.qwTracking.queue
////                : [],
////            track: function (t) {
////              console.log("track");
////              this.queue.push({ type: "track", props: t });
////            },
////            init: function (t) {
////              console.log("init");
////              this.queue.push({ type: "init", props: t });
////            },
////          });
////          window.qwSettings;
////          var t = function (t) {
////            console.log("create",window?.qwSettings?.appId);
////            var e = document.createElement("script");
////            e.type = "text/javascript";
////            e.async = true;
////            e.src = "/Users/geektech/Documents/QwarySDk/QwaryIos/QwaryIos/qw.intercept.sdk.merged.js?id=" + app_id;
////            var n = document.getElementsByTagName("script")[0];
////            // Satinder Change as n is undefined  n.parentNode.insertBefore(e,n)
////            document.head.appendChild(e);
////          };
////          if (document.readyState === "complete") {
////            t();
////          } else if (window.attachEvent) {
////            window.attachEvent("onload", t);
////          } else {
////            window.addEventListener("load", t, false);
////          }
////        }
////      })();
////      qwTracking.init(qwSettings);
////      """
////  }
////}
