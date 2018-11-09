//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Akamate Chayapiwat on 26/10/2018.
//  Copyright (c) 2018 Akamate. All rights reserved.
//

import UIKit

class ChangeCityViewController: UIViewController {
    
    
    @IBOutlet weak var changeCityTextField: UITextField!

    
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
