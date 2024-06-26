//
//  Readme.md
//  QwaryiOSSdk
//
//  Created by Geek Tech on 27/05/24.
//
import Foundation

 MARK: Qwary iOS SDK Integration Guide
Overview
The Qwary iOS SDK allows you to seamlessly integrate surveys and feedback forms into your iOS application. This guide will walk you through the process of downloading, importing, and configuring the SDK within your project.

Installation Steps
1. Download the Qwary SDK
Download the Qwary SDK from the Qwary website or obtain it from the designated source.

2. Import the SDK Module

1. Open your iOS project in Xcode.
2. Import Qwary module

3. Click Finish to import the module into your project.

4. Configure the SDK 
    (4.1) (Go to  Project Target/General/Frameworks,Libraries)
    (4.2) Find the Qwary Framework
    (4.3) Set the Embed&signIn for Qwary Framework
Obtain Your App ID
To configure the SDK, you need to obtain your unique App ID from your Qwary account. Follow these steps to find it:

1. Log in to your Qwary account.
2. Navigate to the "Integration" section.
3. Locate your App ID in the provided information.

4. Initialize the SDK
Initialize the Qwary SDK in your application's onViewDidLoad() method or another appropriate location.
5.class ViewController: UIViewController {
    let appId = "YOUR_QWARY_APP_ID"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Configure the Qwary SDK
        Qwary.configure(context: self, qwSettings: appId)
        
    }
}

6. Add Events to the Queue
To add events to the queue, use the following code snippet:

Qwary.addEvent("EventName")

Replace "EventName" with the name of the event you want to track.

Display Surveys and Feedback Forms
You can now display surveys and feedback forms to your users using the Qwary SDK. Refer to the SDK documentation for detailed instructions on how to create and present surveys and feedback forms.

Support
If you encounter any issues or have questions regarding the Qwary Android SDK integration, please reach out to Qwary Support.

License
This SDK is licensed under the Apache License 2.0.
