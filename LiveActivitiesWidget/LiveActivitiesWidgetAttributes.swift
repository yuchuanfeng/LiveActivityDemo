//
//  LiveActivitiesWidgetAttributes.swift
//  LiveActivityDemo
//
//  Created by yuchuanfeng on 2023/3/3.
//

import ActivityKit
import Foundation

/// 描述实时活动的数据
struct LiveActivitiesWidgetAttributes: ActivityAttributes {
    // 动态数据 update
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var progress: Int
        var statusName: String
    }
    
    // 静态数据
    var name: String
}
