//
//  BaseTableView.swift
//  YoutubeApi
//
//  Created by vlad on 5/29/22.
//  Copyright © 2022 Vlad Lazoryk. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rowHeight = 110
        self.showsVerticalScrollIndicator = false
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets.zero
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
