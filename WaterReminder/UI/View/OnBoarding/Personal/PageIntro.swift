//
//  PageIntro.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 03/11/1445 AH.
//

import Foundation
import SwiftUI

struct PageIntro:Identifiable,Hashable {
    var id = UUID()
    var introAssetImage:String
    var title:String
    var subTitle:String
    var dispaysActions:Bool = false
}

var pagesIntro:[PageIntro] = [

    .init(introAssetImage: "image1", title: "Welcome to Hydration Central!", subTitle: "Ready to dive into the ocean of hydration? Let’s make sure you’re not just a fish out of water!"),
    .init(introAssetImage: "image2", title: "Your Personal Hydration Reports", subTitle: "Think of us as your personal hydration detective, always on the case!"),
//    .init(introAssetImage: "image4", title: "Don’t Forget to Hydrate! 💧", subTitle: "Can we send you reminders to drink water? We promise we won’t spam you… unless you count delicious, life-saving water as spam! 🚰😄"),
    .init(introAssetImage: "image3", title: "A Little Info Goes a Long Way", subTitle: "Just a splash more info and you’ll be all set to flow!",dispaysActions: true)

]
