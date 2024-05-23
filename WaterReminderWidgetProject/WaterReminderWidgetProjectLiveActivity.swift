//
//  WaterReminderWidgetProjectLiveActivity.swift
//  WaterReminderWidgetProject
//
//  Created by Ammar Ahmed on 04/11/1445 AH.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WaterReminderWidgetProjectAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WaterReminderWidgetProjectLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WaterReminderWidgetProjectAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

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
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WaterReminderWidgetProjectAttributes {
    fileprivate static var preview: WaterReminderWidgetProjectAttributes {
        WaterReminderWidgetProjectAttributes(name: "World")
    }
}

extension WaterReminderWidgetProjectAttributes.ContentState {
    fileprivate static var smiley: WaterReminderWidgetProjectAttributes.ContentState {
        WaterReminderWidgetProjectAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WaterReminderWidgetProjectAttributes.ContentState {
         WaterReminderWidgetProjectAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WaterReminderWidgetProjectAttributes.preview) {
   WaterReminderWidgetProjectLiveActivity()
} contentStates: {
    WaterReminderWidgetProjectAttributes.ContentState.smiley
    WaterReminderWidgetProjectAttributes.ContentState.starEyes
}
