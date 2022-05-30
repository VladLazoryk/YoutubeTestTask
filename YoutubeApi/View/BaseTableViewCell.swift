//
//  BaseTableViewCell.swift
//  YoutubeApi
//
//  Created by vlad on 5/29/22.
//  Copyright © 2022 Vlad Lazoryk. All rights reserved.
//

import UIKit

class BaseTableViewCell : UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
