//
//  ViewController.swift
//  LiveActivityDemo
//
//  Created by yuchuanfeng on 2023/3/3.
//

import UIKit
import ActivityKit

class ViewController: UIViewController {
    var deliveryActivity: Activity<LiveActivitiesWidgetAttributes>? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let acs = Activity<LiveActivitiesWidgetAttributes>.activities
        print("current acs: \(acs)")
        UNUserNotificationCenter.current().requestAuthorization(options: .alert) { result, error in
            print("noti setting: \(result)")
            if let e = error {
                print("noti setting error: \(e)")
            }
        }
        UNUserNotificationCenter.current().getNotificationSettings { setting in
            print("noti setting: \(setting.authorizationStatus)")
        }
    }

    // 创建实时活动
    @IBAction func startLiveActivity(_ sender: Any) {
        let initialContentState = LiveActivitiesWidgetAttributes.ContentState(progress: 3, statusName: "start")
        let contentState = ActivityContent(state: initialContentState, staleDate: nil)
        // 只有创建的时候赋值
        let activityAttributes = LiveActivitiesWidgetAttributes(name: "testName-zhangsan")
        do {
            // 主工程更新
            deliveryActivity = try Activity.request(attributes: activityAttributes, content:contentState)
            // 远程push 更新
//            deliveryActivity = try Activity.request(attributes: activityAttributes, content:contentState, pushType: PushType.token)
            // 获取token
//            guard let liveActivity = deliveryActivity else { return }
//            Task {
//                for await activityPushToken in liveActivity.pushTokenUpdates {
//                    let myToken = activityPushToken.map {String(format: "%02x", $0)}.joined()
//                }
//            }
        } catch {
            // 如果没有实时活动权限，会报错
            // 如果是 push 更新，没有push权限，也会报错
            print("ActivityKit start error: \(error)")
        }
    }
    // 更新
    var progress = 0
    @IBAction func updateLiveActivity(_ sender: Any) {
        progress += 10
        // update 只有更新 ContentState 数据
        let initialContentState = LiveActivitiesWidgetAttributes.ContentState(progress: progress, statusName: "doing")
        let contentState = ActivityContent(state: initialContentState, staleDate: nil)
        // 更新时，可传alert
        let alertConfiguration = AlertConfiguration(title: "alert", body: "alert body", sound: .default)
        Task {
            try? await Task.sleep(nanoseconds: UInt64(5 * Double(NSEC_PER_SEC)))
            await deliveryActivity?.update(contentState, alertConfiguration: alertConfiguration)
        }
    }
    
    @IBAction func endLiveActivity(_ sender: Any) {
        // end 只有更新 ContentState 数据
        let initialContentState = LiveActivitiesWidgetAttributes.ContentState(progress: 100, statusName: "finished")
        let contentState = ActivityContent(state: initialContentState, staleDate: nil)
        Task {
            try? await Task.sleep(nanoseconds: UInt64(5 * Double(NSEC_PER_SEC)))
            // 结束，但 锁屏页仍保留 live activity 信息
            await deliveryActivity?.end(contentState)
            // 结束，设置锁屏 live activity 信息 移除时间
//            await deliveryActivity?.end(contentState, dismissalPolicy: .after(.now + 5))
        }
    }
    

}

