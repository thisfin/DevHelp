//
//  ColorCollectionViewItem.swift
//  DevHelp
//
//  Created by wenyou on 2017/7/6.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import AppKit
import SnapKit
import WYKit

class ColorCollectionViewItem: NSCollectionViewItem {
    let colorView = NSView()
    let titleField = NSTextField()
    let contentField = NSTextField()

    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        colorView.wantsLayer = true
        colorView.layer?.borderWidth = 1
        colorView.layer?.borderColor = NSColor.black.cgColor
        view.addSubview(colorView)
        colorView.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(view.snp.centerY).offset(-5)
            maker.left.equalToSuperview().offset(10)
            maker.width.equalTo(50)
            maker.height.equalTo(20)
        }

        titleField.isEditable = false
        titleField.isSelectable = true
        titleField.isBordered = false
        titleField.backgroundColor = .clear
        view.addSubview(titleField)
        titleField.snp.makeConstraints { (maker) in
            maker.top.equalTo(view.snp.centerY).offset(5)
            maker.left.equalToSuperview().offset(10)
            maker.right.equalToSuperview().offset(-10)
        }

        contentField.isEditable = false
        contentField.isSelectable = true
        contentField.isBordered = false
        contentField.backgroundColor = .clear
        view.addSubview(contentField)
        contentField.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(colorView)
            maker.left.equalTo(colorView.snp.right).offset(10)
            maker.right.equalToSuperview().offset(-10)
            maker.height.equalTo(colorView)
        }
    }

    func configData(colorData: ColorData) {
        colorView.layer?.backgroundColor = colorData.color.cgColor
        titleField.stringValue = colorData.title
        contentField.stringValue = colorData.color.toHexString()
    }
}
