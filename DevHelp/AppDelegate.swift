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
    var windowControllers = [NSWindowController]()
    let menuItemValues = [
        "system color": ColorWindowController.className(),
        "color select": SelectColorWindowController.className()]

    fileprivate func setStatusItem() {
        statusItem.image = WYIconfont.imageWithIcon(content: "\u{f17a}", backgroundColor: .clear, iconColor: .black, size: NSMakeSize(20, 20))
        statusItem.menu = NSMenu().then({ (this) in
            menuItemValues.forEach({ (title, className) in
                this.addItem(withTitle: title, action: #selector(AppDelegate.openWindow(_:)), keyEquivalent: "")
            })
            this.addItem(withTitle: "close", action: #selector(AppDelegate.close(_:)), keyEquivalent: "")
            this.addItem(withTitle: "say hello", action: #selector(AppDelegate.sayHello(_:)), keyEquivalent: "")
            this.addItem(NSMenuItem.separator())
            this.addItem(withTitle: "Quit \(ProcessInfo.processInfo.processName)", action: #selector(NSApp.terminate(_:)), keyEquivalent: "")
        })
    }

    func close(_ sender: NSMenuItem) {
    }

    func sayHello(_ sender: NSMenuItem) {
        NSLog("hello world")
    }

    func openWindow(_ sender: NSMenuItem) {
        guard let className = menuItemValues[sender.title] else {
            return
        }

        var isOpen = false
        windowControllers.forEach { (windowController) in
            if windowController.className == className {
                windowController.showWindow(self)
                isOpen = true
                return
            }
        }

        if !isOpen, let type = NSClassFromString(className) as? NSWindowController.Type {
            let controller = type.init()
            windowControllers.append(controller)
            controller.window?.center()
            controller.showWindow(self)
        }
    }

    func notificationHandle(_ notification: Notification) {
        switch notification.name {
        case Notification.Name.NSWindowWillClose:
            if let window = notification.object as? NSWindow, let windowController = window.windowController, let index = windowControllers.index(of: windowController) {
                windowControllers.remove(at: index)
            }
        default:
            ()
        }
    }
}

extension AppDelegate: NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NotificationCenter.default.addObserver(self, selector: #selector(notificationHandle(_:)), name: .NSWindowWillClose, object: nil)

        setStatusItem()

        openWindow(NSMenuItem.init().then({ (this) in
            this.title = "color select"
        }))
    }

    func applicationWillTerminate(_ notification: Notification) {
        NotificationCenter.default.removeObserver(self, name: .NSWindowWillClose, object: nil)
    }
}
