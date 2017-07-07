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
    var nowColorView: ColorView?

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
        backView.contorller = self
        frontView.contorller = self

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


        textField.callbackBlock = { (color) in
            if let view = self.nowColorView {
                view.setNowColor(color: color)
            }
        }
        frontView.callbackBlock = { (color) in
            self.textField.stringValue = color.toHexString(prefix: .null, includeAlpha: true)
        }
        backView.callbackBlock = { (color) in
            self.textField.stringValue = color.toHexString(prefix: .null, includeAlpha: true)
        }
    }

    override func viewWillAppear() {
        super.viewWillAppear()
    }

    func textColorChange(color: NSColor) {

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
            if let block = callbackBlock, color != .clear {
                block(color)
            }
        }
    }
}

class ColorView: NSView {
    var callbackBlock: ((NSColor) -> Void)?
    weak var panel: NSColorPanel?
    weak var contorller: SelectColorViewController?

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
        if let cv = contorller {
            cv.nowColorView = self
        }
        self.panel = panel
    }

    func setNowColor(color: NSColor) {
        if let p = panel { // 设置颜色时关闭回调
            let temp = callbackBlock
            callbackBlock = nil
            p.color = color
            callbackBlock = temp
        } else {
            layer?.backgroundColor = color.cgColor
        }
    }

    func colorSelect(_ sender: NSColorPanel) {
        layer?.backgroundColor = sender.color.cgColor
        if let block = callbackBlock {
            block(sender.color)
        }
    }
}
