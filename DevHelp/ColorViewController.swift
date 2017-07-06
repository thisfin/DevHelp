//
//  ColorViewController.swift
//  DevHelp
//
//  Created by wenyou on 2017/7/6.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import AppKit

class ColorViewController: NSViewController {
    private var collectionView: NSCollectionView!
    fileprivate let colorDatas = [
        ColorData(color: .black,        title: #keyPath(NSColor.black)),        /* 0.0 white */
        ColorData(color: .darkGray,     title: #keyPath(NSColor.darkGray)),     /* 0.333 white */
        ColorData(color: .lightGray,    title: #keyPath(NSColor.lightGray)),    /* 0.667 white */
        ColorData(color: .white,        title: #keyPath(NSColor.white)),        /* 1.0 white */
        ColorData(color: .gray,         title: #keyPath(NSColor.gray)),         /* 0.5 white */
        ColorData(color: .red,          title: #keyPath(NSColor.red)),          /* 1.0, 0.0, 0.0 RGB */
        ColorData(color: .green,        title: #keyPath(NSColor.green)),        /* 0.0, 1.0, 0.0 RGB */
        ColorData(color: .blue,         title: #keyPath(NSColor.blue)),         /* 0.0, 0.0, 1.0 RGB */
        ColorData(color: .cyan,         title: #keyPath(NSColor.cyan)),         /* 0.0, 1.0, 1.0 RGB */
        ColorData(color: .yellow,       title: #keyPath(NSColor.yellow)),       /* 1.0, 1.0, 0.0 RGB */
        ColorData(color: .magenta,      title: #keyPath(NSColor.magenta)),      /* 1.0, 0.0, 1.0 RGB */
        ColorData(color: .orange,       title: #keyPath(NSColor.orange)),       /* 1.0, 0.5, 0.0 RGB */
        ColorData(color: .purple,       title: #keyPath(NSColor.purple)),       /* 0.5, 0.0, 0.5 RGB */
        ColorData(color: .brown,        title: #keyPath(NSColor.brown)),        /* 0.6, 0.4, 0.2 RGB */
        ColorData(color: .clear,        title: #keyPath(NSColor.clear)),        /* 0.0 white, 0.0 alpha */
        ColorData(color: .controlShadowColor,
                  title: #keyPath(NSColor.controlShadowColor)),                 // Dark border for controls
        ColorData(color: .controlDarkShadowColor,
                  title: #keyPath(NSColor.controlDarkShadowColor)),             // Darker border for controls
        ColorData(color: .controlColor,
                  title: #keyPath(NSColor.controlColor)),                       // Control face and old window background color
        ColorData(color: .controlHighlightColor,
                  title: #keyPath(NSColor.controlHighlightColor)),              // Light border for controls
        ColorData(color: .controlLightHighlightColor,
                  title: #keyPath(NSColor.controlLightHighlightColor)),         // Lighter border for controls
        ColorData(color: .controlTextColor,
                  title: #keyPath(NSColor.controlTextColor)),                   // Text on controls
        ColorData(color: .controlBackgroundColor,
                  title: #keyPath(NSColor.controlBackgroundColor)),             // Background of large controls (browser, tableview, clipview, ...)
        ColorData(color: .selectedControlColor,
                  title: #keyPath(NSColor.selectedControlColor)),               // Control face for selected controls
        ColorData(color: .secondarySelectedControlColor,
                  title: #keyPath(NSColor.secondarySelectedControlColor)),      // Color for selected controls when control is not active (that is, not focused)
        ColorData(color: .selectedControlTextColor,
                  title: #keyPath(NSColor.selectedControlTextColor)),           // Text on selected controls
        ColorData(color: .disabledControlTextColor,
                  title: #keyPath(NSColor.disabledControlTextColor)),           // Text on disabled controls
        ColorData(color: .textColor,
                  title: #keyPath(NSColor.textColor)),                          // Document text
        ColorData(color: .textBackgroundColor,
                  title: #keyPath(NSColor.textBackgroundColor)),                // Document text background
        ColorData(color: .selectedTextColor,
                  title: #keyPath(NSColor.selectedTextColor)),                  // Selected document text
        ColorData(color: .selectedTextBackgroundColor,
                  title: #keyPath(NSColor.selectedTextBackgroundColor)),        // Selected document text background
        ColorData(color: .gridColor,
                  title: #keyPath(NSColor.gridColor)),                          // Grids in controls
        ColorData(color: .keyboardFocusIndicatorColor,
                  title: #keyPath(NSColor.keyboardFocusIndicatorColor)),        // Keyboard focus ring around controls
        ColorData(color: .windowBackgroundColor,
                  title: #keyPath(NSColor.windowBackgroundColor)),              // Background fill for window contents
        ColorData(color: .underPageBackgroundColor,
                  title: #keyPath(NSColor.underPageBackgroundColor)),           // Background areas revealed behind views
        ColorData(color: .labelColor,
                  title: #keyPath(NSColor.labelColor)),                         // Text color for static text and related elements
        ColorData(color: .secondaryLabelColor,
                  title: #keyPath(NSColor.secondaryLabelColor)),                // Text color for secondary static text and related elements
        ColorData(color: .tertiaryLabelColor,
                  title: #keyPath(NSColor.tertiaryLabelColor)),                 // Text color for disabled static text and related elements
        ColorData(color: .quaternaryLabelColor,
                  title: #keyPath(NSColor.quaternaryLabelColor)),               // Text color for large secondary or disabled static text, separators, large glyphs/icons, etc
        ColorData(color: .scrollBarColor,
                  title: #keyPath(NSColor.scrollBarColor)),                     // Scroll bar slot color
        ColorData(color: .knobColor,
                  title: #keyPath(NSColor.knobColor)),                          // Knob face color for controls
        ColorData(color: .selectedKnobColor,
                  title: #keyPath(NSColor.selectedKnobColor)),                  // Knob face color for selected controls
        ColorData(color: .windowFrameColor,
                  title: #keyPath(NSColor.windowFrameColor)),                   // Window frames
        ColorData(color: .windowFrameTextColor,
                  title: #keyPath(NSColor.windowFrameTextColor)),               // Text on window frames
        ColorData(color: .selectedMenuItemColor,
                  title: #keyPath(NSColor.selectedMenuItemColor)),              // Highlight color for menus
        ColorData(color: .selectedMenuItemTextColor,
                  title: #keyPath(NSColor.selectedMenuItemTextColor)),          // Highlight color for menu text
        ColorData(color: .highlightColor,
                  title: #keyPath(NSColor.highlightColor)),                     // Highlight color for UI elements (this is abstract and defines the color all highlights tend toward)
        ColorData(color: .shadowColor,
                  title: #keyPath(NSColor.shadowColor)),                        // Shadow color for UI elements (this is abstract and defines the color all shadows tend toward)
        ColorData(color: .headerColor,
                  title: #keyPath(NSColor.headerColor)),                        // Background color for header cells in Table/OutlineView
        ColorData(color: .headerTextColor,
                  title: #keyPath(NSColor.headerTextColor)),                    // Text color for header cells in Table/OutlineView
        ColorData(color: .alternateSelectedControlColor,
                  title: #keyPath(NSColor.alternateSelectedControlColor)),      // Similar to selectedControlColor; for use in lists and tables
        ColorData(color: .alternateSelectedControlTextColor,
                  title: #keyPath(NSColor.alternateSelectedControlTextColor))   // Similar to selectedControlTextColor; see alternateSelectedControlColor
    ]

    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
        view.frame = NSRect(origin: .zero, size: NSMakeSize(800, 600))

        collectionView = NSCollectionView.init()
        collectionView.collectionViewLayout = NSCollectionViewFlowLayout()
        collectionView.register(ColorCollectionViewItem.classForCoder(), forItemWithIdentifier: ColorCollectionViewItem.className())
        collectionView.dataSource = self
        collectionView.delegate = self

        let scrollView = NSScrollView()
        scrollView.backgroundColor = .red
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        scrollView.contentView.documentView = collectionView
        scrollView.documentView = collectionView
    }

    override func viewWillAppear() {
        super.viewWillAppear()
    }
}

extension ColorViewController: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorDatas.count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let collectionViewItem = collectionView.makeItem(withIdentifier: ColorCollectionViewItem.className(), for: indexPath)
        if let item = collectionViewItem as? ColorCollectionViewItem {
            item.configData(colorData: colorDatas[indexPath.item])
        }
        return collectionViewItem
    }
}

extension ColorViewController: NSCollectionViewDelegate {

}

extension ColorViewController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSMakeSize(220, 60)
    }

    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

struct ColorData {
    let color: NSColor
    let title: String
}
