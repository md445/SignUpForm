//
//  ViewController.swift
//  signup
//
//  Created by Mahesh Dhumpeti on 30/03/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapped() {
        let controller = SignUpFormViewController(nibName: "SignUpFormViewController", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        present(controller, animated: true, completion: nil)
    }


}

