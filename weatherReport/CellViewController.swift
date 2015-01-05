//
//  CellViewController.swift
//  weatherReport
//
//  Created by yokoyama.tatsuya on 2015/01/03.
//  Copyright (c) 2015年 yokoyama.tatsuya. All rights reserved.
//

import UIKit

class CellViewController: UIViewController {
    var selectedRow : Int?
    
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
    }
    func makeView() {
        self.myLabel.text = WeatherMaster.sharedInstance.getArray()[self.selectedRow!] as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
