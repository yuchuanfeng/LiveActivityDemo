//
//  LiveActivitiesWidgetBundle.swift
//  LiveActivitiesWidget
//
//  Created by yuchuanfeng on 2023/3/3.
//

import WidgetKit
import SwiftUI

@main
struct LiveActivitiesWidgetBundle: WidgetBundle {
    var body: some Widget {
        LiveActivitiesWidget()
        LiveActivitiesWidgetLiveActivity()
    }
}
