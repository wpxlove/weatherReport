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
    let dateFormatter = NSDateFormatter()

    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet var myImage: UIImageView!
    
    @IBOutlet var mainLabel: UILabel!
    
    @IBOutlet var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
    }
    func makeView() {
        var weather : AnyObject = WeatherMaster.sharedInstance.getArray()[self.selectedRow!]
        self.setConfig()
        var dtStr = weather["dtStr"] as NSString
        var dtDate = NSDate(timeIntervalSince1970:dtStr.doubleValue)
        self.myLabel.text = self.dateFormatter.stringFromDate(dtDate)
        self.mainLabel.text = weather["temp"] as String!
        self.descLabel.text = weather["description"] as String!
        var icon = weather["icon"] as String!
        self.myImage?.image = UIImage(named:"\(icon).png")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // dateFormatterのパラメーターを設定
    func setConfig() {
        self.dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        self.dateFormatter.timeStyle = .LongStyle
        self.dateFormatter.dateStyle = .LongStyle
    }
}
