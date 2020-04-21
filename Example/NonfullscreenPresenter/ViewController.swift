//
//  ViewController.swift
//  NonfullscreenPresenter
//
//  Created by Chen Qizhi on 04/21/2020.
//  Copyright (c) 2020 Chen Qizhi. All rights reserved.
//

import UIKit
import NonfullscreenPresenter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(_ sender: UIButton) {
        let avc = AlertViewController()
        np.present(avc)
    }

    @IBAction func showActionSheet(_ sender: UIButton) {
        let asvc = ActionSheetViewController()
        np.present(asvc)
    }

}

