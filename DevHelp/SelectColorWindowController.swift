//
//  SelectColorWindowController.swift
//  DevHelp
//
//  Created by wenyou on 2017/7/6.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import AppKit

class SelectColorWindowController: NSWindowController {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(window: NSWindow?) {
        super.init(window: window)

        if window == nil {
            self.window = NSWindow.init().then({ (this) in
                this.styleMask = [.closable, .miniaturizable, .titled]
                this.contentViewController = SelectColorViewController()
            })
        }
    }
}
