import Foundation
import UIKit
import WebKit

class AlertHelper {

    private var alertController: UIAlertController = UIAlertController()
    static let shared = AlertHelper()
    
    func showAlert(on viewController: UIViewController,
                   title: String,
                   message: String,
                   shouldShowWebView: Bool,
                   web: WKWebView) {
        
        
        
        if shouldShowWebView{
            alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            // Create WKWebView
            let screenHeight = UIScreen.main.bounds.height
            _ = screenHeight / 3
            
            // Add your custom view to the action sheet
            let customViewWidth = UIScreen.main.bounds.width
            let frame = CGRect(x: 0, y: 0, width: customViewWidth - 12, height: 300)
            web.frame = frame
            //webView.load(URLRequest(url: webViewURL))
            //web.loadFileURL(webViewURL, allowingReadAccessTo: webViewURL)
            
            // Create UIViewController to hold the WKWebView
            
            // Add the webViewController as a child of UIAlertController
            //alertController.setValue(webViewController, forKey: "contentViewController")
            let dismissAction1 = UIAlertAction(title: "", style: .default, handler: nil)
            let dismissAction2 = UIAlertAction(title: "", style: .default, handler: nil)
            let dismissAction3 = UIAlertAction(title: "", style: .default, handler: nil)
            let dismissAction = UIAlertAction(title: "", style: .cancel, handler: nil)
            alertController.addAction(dismissAction1)
            alertController.addAction(dismissAction2)
            alertController.addAction(dismissAction3)
            alertController.addAction(dismissAction)
            
            alertController.view.addSubview(web)
            viewController.present(alertController, animated: true, completion: nil)
        }else{
            print("Alert is not Displayed Because shouldShowWebView is false")
        }
        
        
    }
    
    func dismissAlert() {
        alertController.dismiss(animated: true, completion: nil)
    }
}
