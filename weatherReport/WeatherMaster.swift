//
//  WeatherMaster.swift
//  weatherReport
//
//  Created by Tatsuya Yokoyama on 2015/01/05.
//  Copyright (c) 2015年 yokoyama.tatsuya. All rights reserved.
//

import Foundation
import Darwin

class WeatherMaster {
    var array = NSMutableArray()
    var dateFormatter : NSDateFormatter = NSDateFormatter()
    class var sharedInstance : WeatherMaster {
        struct Singleton {
            static var instance = WeatherMaster()
        }
        return Singleton.instance
    }

    // API叩いてself.arrayを更新
    func update() {
        setConfig()
        var url = NSURL(string: Const.apiUrlString)!
        var task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error in
            var json = JSON(data: data)
            for var i = 0; i < Const.tableCellNum; i++ {
                var dtStr = json["list"][i]["dt"].stringValue! as NSString
                var dtDate = NSDate(timeIntervalSince1970:dtStr.doubleValue)
                
                // 未実装
                //var weekDay = self.getWeekDay(dtDate)
                var dt_str = self.dateFormatter.stringFromDate(dtDate)

                // 気温
                var tempStr = json["list"][i]["main"]["temp"].stringValue!
                var tempDouble = atof(tempStr)
                var description = json["list"][i]["weather"][0]["description"].stringValue!
                println(dt_str)
                self.array[i] = [
                    "dt_str" : dt_str,
               //     "humidity" : humidity,
                    "dtStr"  : dtStr,
                    "icon"   : json["list"][i]["weather"][0]["icon"].stringValue!,
                    "main"   : json["list"][i]["weather"][0]["main"].stringValue!,
                    "description" : description,
                    "temp"   : String("\(tempDouble)") + "°C"
                ]
                //println(self.array[i])
            }
            println("post notification")
            // 通信終わったよ通知を送る
            NSNotificationCenter.defaultCenter().postNotificationName("updatedWeatherMaster", object: nil);

        })
        task.resume()
    }
    func getArray() -> NSMutableArray {
        println("getter array")
        return self.array
    }
    // dateFormatterのパラメーターを設定
    func setConfig() {
        self.dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        self.dateFormatter.dateFormat = "MM/dd HH:mm"
    }
    // 未使用
    // 曜日を取得
    func getWeekDay(date : NSDate) -> String {
        var weekDay : String
        var allWeekDay = Const.allWeekDay
        var calendar = NSCalendar(calendarIdentifier: NSJapaneseCalendar)!
        var comps: NSDateComponents = calendar.components(NSCalendarUnit.WeekdayCalendarUnit,fromDate: date)
        weekDay = allWeekDay[comps.weekday]
        return weekDay
    }
}