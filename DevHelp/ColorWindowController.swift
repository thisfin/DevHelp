//
//  ColorWindowController.swift
//  DevHelp
//
//  Created by wenyou on 2017/7/6.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import AppKit

class ColorWindowController: NSWindowController {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(window: NSWindow?) {
        super.init(window: window)

        if window == nil {
            self.window = NSWindow.init().then({ (this) in
                this.styleMask = [.closable, .resizable, .miniaturizable, .titled]
                this.minSize = NSMakeSize(400, 300)
                this.contentViewController = ColorViewController()
            })
        }
    }
}
