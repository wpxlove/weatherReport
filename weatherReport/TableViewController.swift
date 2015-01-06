//
//  TableViewController.swift
//  weatherReport
//
//  Created by yokoyama.tatsuya on 2015/01/03.
//  Copyright (c) 2015年 yokoyama.tatsuya. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // var cellItemsにデータが入ってるかどうか
    var hasCellItems = false;
    
    // 選択されたセルの列番号
    var selectedRow: Int?
    
    // セルの中身
    var cellItems = NSMutableArray()

    override func viewDidLoad() {
        // observerとして登録
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notificationDid:", name: "updatedWeatherMaster", object: nil)
        // API叩く
        WeatherMaster.sharedInstance.update()
        // tableの高さ変更
        self.tableView.rowHeight = 50
        super.viewDidLoad()
        
        // プルダウンでリロード機能の付加
        addRefreshControl()
        println("finish view did load")
    }
    // プルダウンでリロード機能を付加
    func addRefreshControl() {
        var refresh = UIRefreshControl()
        // ロード時に表示される文字を設定
        refresh.attributedTitle = NSAttributedString(string: "Loading...")
        // プルダウン時に呼び出されるメソッドを設定
        refresh.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refresh
    }

    // APIデータ取得完了後に呼び出される
    func notificationDid(notification : NSNotification?) {
        self.hasCellItems = false
        updateCellItems()
        loadTableData()
    }
    // cellにデータをつっこむ
    func updateCellItems() {
        self.cellItems = WeatherMaster.sharedInstance.getArray()
        self.hasCellItems = true
    }
    func loadTableData() {
        // tableviewの更新
        // main threadで実行させないとtableが更新されないので、無理やりこうしてる
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }
    func refreshData() {
        println("start refresh")
        // API叩く
        WeatherMaster.sharedInstance.update()
        updateCellItems()
        loadTableData()
        refreshControl?.endRefreshing()
        println("end refresh")
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
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as CustomCell
      //  println(self.cellItems)
        // データ持ってたら突っ込む
        if self.hasCellItems {
            // Configure the cell...
            //let mainLabel = tableView.viewWithTag(1) as UILabel
            //mainLabel.text = "aaaaaaaaaa"
            //cell.mainLabel.text = self.cellItems[indexPath.row]["dt_txt"] as String!
            //cell.subLabel.text = self.cellItems[indexPath.row]["main"] as String!
            var icon = self.cellItems[indexPath.row]["icon"] as String!
            //var img = UIImage(named: "Supporting Files/01d.png")
           // cell.myImage.image = UIImage(image: img)
            cell.myImage?.image = UIImage(named:"\(icon).png")
        } else {
            println("not has cell data")
        }
        return cell
    }
    override func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedRow = indexPath.row
        performSegueWithIdentifier("toCellViewController", sender: nil)
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
