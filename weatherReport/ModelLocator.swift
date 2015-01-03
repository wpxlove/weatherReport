//
//  ModelLocator.swift
//  weatherReport
//
//  Created by yokoyama.tatsuya on 2015/01/03.
//  Copyright (c) 2015年 yokoyama.tatsuya. All rights reserved.
//

import Foundation

class ModelLocator {
    class var sharedInstance : ModelLocator {
        struct Singleton {
            static var instance = ModelLocator()
        }
        return Singleton.instance
    }
    var events = EventModel()
    init() {
        println("ModelLocator init")
    }
    func getEvent() -> EventModel {
        return events
    }
    func setEvent(array:EventModel) -> EventModel {
        events = array
        return events
    }
}
