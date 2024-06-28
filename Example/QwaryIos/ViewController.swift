//
//  ViewController.swift
//  QwaryIos
//
//  Created by devgeektech on 06/28/2024.
//  Copyright (c) 2024 devgeektech. All rights reserved.
//

import UIKit
import QwaryIos
class ViewController: UIViewController {
    var app_id = "c5e3e8c3-5b12-481d-a4c9-1570bd532860"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Qwary.configure(context: self, qwSettings: app_id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

