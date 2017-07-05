//
//  AppDelegate.swift
//  DevHelp
//
//  Created by wenyou on 2017/7/5.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import Cocoa
import WYKit

@NSApplicationMain
class AppDelegate: NSObject {
    lazy var statusItem: NSStatusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)

    fileprivate func setStatusItem() {
        statusItem.image = WYIconfont.imageWithIcon(content: "\u{f17a}", backgroundColor: .clear, iconColor: .black, size: NSMakeSize(20, 20))
        statusItem.menu = NSMenu().then({ (this) in
            this.addItem(withTitle: "say hello", action: #selector(AppDelegate.sayHello(_:)), keyEquivalent: "")
            this.addItem(NSMenuItem.separator())
            this.addItem(withTitle: "Quit \(ProcessInfo.processInfo.processName)", action: #selector(NSApp.terminate(_:)), keyEquivalent: "")
        })
    }

    func sayHello(_ sender: NSMenuItem) {
        NSLog("hello world")
    }
}

extension AppDelegate: NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setStatusItem()
    }
}
