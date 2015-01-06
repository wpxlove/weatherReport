//
//  WeatherMaster.swift
//  weatherReport
//
//  Created by Tatsuya Yokoyama on 2015/01/05.
//  Copyright (c) 2015年 yokoyama.tatsuya. All rights reserved.
//

import Foundation


class WeatherMaster {
    var array = NSMutableArray()
    class var sharedInstance : WeatherMaster {
        struct Singleton {
            static var instance = WeatherMaster()
        }
        return Singleton.instance
    }

    // API叩いてself.arrayを更新
    func update() {
        var url = NSURL(string: Const.apiUrlString)!
        var task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error in
            var json = JSON(data: data)
            for var i = 0; i < Const.tableCellNum; i++ {
                var dt_txt = json["list"][i]["dt_txt"]
                var weatherMain = json["list"][i]["weather"][0]["main"]
                var weatherDescription = json["list"][i]["weather"][0]["description"]
                var info = "\(dt_txt), \(weatherMain), \(weatherDescription)"
                self.array[i] = info
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
}