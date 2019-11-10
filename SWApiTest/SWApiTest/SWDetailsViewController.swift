//
//  SWDetailsViewController.swift
//  SWApiTest
//
//  Created by LBR on 06.11.2019.
//  Copyright © 2019 Bogdan Sorobei. All rights reserved.
//

import UIKit

class SWDetailsViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    public var starship: Starship?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = starship?.films?.joined(separator: "\n")
    }
    
}
