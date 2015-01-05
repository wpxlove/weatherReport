//
//  TableViewController.swift
//  weatherReport
//
//  Created by yokoyama.tatsuya on 2015/01/03.
//  Copyright (c) 2015年 yokoyama.tatsuya. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // ロード中
    var hasCellData = false;
    
    // 選択されたセルの列番号
    var selectedRow: Int?

    override func viewDidLoad() {
        println("superl load start")
        super.viewDidLoad()
                println("superl load end")

        println("update json data outer")
        WeatherMaster.sharedInstance.update()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "update:", name: "updatedWeatherMaster", object: nil)
        println("update json data end")
    }

    func update(notif: NSNotification) {
        println("start make object for table data")
        self.hasCellData = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return Const.tableSectionNum
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return Const.tableCellNum
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.sleepInLoading()
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as UITableViewCell
        // Configure the cell...
        cell.textLabel.text = WeatherMaster.sharedInstance.getArray()[indexPath.row] as? String
        return cell
    }
    override func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedRow = indexPath.row
        performSegueWithIdentifier("toCellViewController", sender: nil)
    }
    // こんなメソッド使わなくても、
    // NSNotificationCenterでどうにかできないものか。。。
    func sleepInLoading() {
        while !self.hasCellData {
            usleep(1000)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "toCellViewController" {
            // 遷移先のViewContollerに、選択された行を渡す
            let cellVC : CellViewController = segue.destinationViewController as CellViewController
            cellVC.selectedRow = self.selectedRow!
        }
    }

}
