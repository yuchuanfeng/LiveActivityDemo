//
//  LiveActivitiesWidgetLiveActivity.swift
//  LiveActivitiesWidget
//
//  Created by yuchuanfeng on 2023/3/3.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivitiesWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Spacer(minLength: 30)
                
                Link(destination: URL(string: "http://www.baidu.com")!, label: {
                    Label {
                        Text("Hello: " + context.attributes.name ).foregroundColor(.white)
                    } icon: {
                        Image(systemName: "bag")
                            .foregroundColor(.white)
                    }
                    .font(.bold(.title)())
                })
                
                
                Spacer()
                Label {
                    Text("Progress: " + String(context.state.progress)).foregroundColor(.yellow)
                } icon: {
                    Image(systemName: "timer")
                        .foregroundColor(.yellow)
                }
                .font(.bold(.title)())
                
                Spacer()
                Label {
                    Text("statusName: " + context.state.statusName ).foregroundColor(.yellow)
                } icon: {
                    Image(systemName: "pencil")
                        .foregroundColor(.yellow)
                }
                .font(.bold(.title)())
                .widgetURL(URL(string: "http://www.google.com"))
            }
            Spacer(minLength: 30)
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.indigo)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T")
            } minimal: {
                Text("Min")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

//struct LiveActivitiesWidgetLiveActivity_Previews: PreviewProvider {
//    static let attributes = LiveActivitiesWidgetAttributes(name: "Me")
//    static let contentState = LiveActivitiesWidgetAttributes.ContentState(value: 3, driverName: "zhangsan")
//
//    static var previews: some View {
//        attributes
//            .previewContext(contentState, viewKind: .dynamicIsland(.compact))
//            .previewDisplayName("Island Compact")
//        attributes
//            .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
//            .previewDisplayName("Island Expanded")
//        attributes
//            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
//            .previewDisplayName("Minimal")
//        attributes
//            .previewContext(contentState, viewKind: .content)
//            .previewDisplayName("Notification")
//    }
//}
