//
//  ViewController.swift
//  Gophertainment
//
//  Created by Daksh Sharma on 1/29/17.
//  Copyright © 2017 Daksh Sharma. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {


    @IBOutlet weak var searchTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.placeholder = "Search movies, actors, directors..."
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

