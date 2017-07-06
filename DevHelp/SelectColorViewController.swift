//
//  SelectColorViewController.swift
//  DevHelp
//
//  Created by wenyou on 2017/7/6.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import AppKit

class SelectColorViewController: NSViewController {
    let frontView = ColorView()
    let backView = ColorView()

    let textField = ColorTextField()

    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let bottomHeight: CGFloat = 50

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
        view.frame = NSRect(origin: .zero, size: NSMakeSize(420, 420 - 10 + bottomHeight))

        view.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10 + 100)
            make.right.equalToSuperview().offset(0 - 10)
            make.top.equalToSuperview().offset(10 + 100)
            make.bottom.equalToSuperview().offset(0 - bottomHeight - 10)
        }

        view.addSubview(frontView)
        frontView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(0 - 10 - 100)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(0 - bottomHeight - 10 - 100)
        }

        backView.wantsLayer = true
        frontView.wantsLayer = true
        backView.layer?.backgroundColor = NSColor.green.cgColor
        frontView.layer?.backgroundColor = NSColor.blue.cgColor

        let label = NSTextField(labelWithString: "RGB: 6/8位 16进制")
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(0 - 10)
        }

        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(label.snp.right).offset(10)
            make.width.equalTo(100)
            make.bottom.equalTo(label)
        }
        textField.delegate = self


//        let frontTextField = NSTextField()
//        let backTextField = NSTextField()

        textField.callbackBlock = { (color) in
            self.frontView.layer?.backgroundColor = color.cgColor
        }
        frontView.callbackBlock = { (color) in
            self.textField.stringValue = (color.toHexString() as NSString).substring(from: 2)
        }
        backView.callbackBlock = { (color) in
            self.textField.stringValue = (color.toHexString() as NSString).substring(from: 2)
        }
    }

    override func viewWillAppear() {
        super.viewWillAppear()
    }
}

extension SelectColorViewController: NSTextFieldDelegate {
    override func controlTextDidChange(_ obj: Notification) {
        NSLog("")
    }
}

class ColorTextField: NSTextField {
    var callbackBlock: ((NSColor) -> Void)?

    override func textDidChange(_ notification: Notification) {
        if let view = notification.object as? NSTextView, let str = view.string {
            let color = NSColor.colorWithString(str)
            if let block = callbackBlock {
                block(color)
            }
            NSLog("\(str)")
        }
    }
}

class ColorView: NSView {
    var callbackBlock: ((NSColor) -> Void)?

    override func mouseDown(with event: NSEvent) {
        let panel = NSColorPanel.shared().then { (this) in
            this.setTarget(self)
            this.setAction(#selector(ColorView.colorSelect(_:)))
            this.showsAlpha = true
            if let cgColor = layer?.backgroundColor, let color = NSColor(cgColor: cgColor) {
                this.color = color
            }
        }
        panel.makeKeyAndOrderFront(self)
    }

    func colorSelect(_ sender: NSColorPanel) {
        layer?.backgroundColor = sender.color.cgColor
        if let block = callbackBlock {
            block(sender.color)
        }
    }
}
