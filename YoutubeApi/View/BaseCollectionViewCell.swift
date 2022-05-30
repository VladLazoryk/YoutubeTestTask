//
//  BaseCollectionViewCell.swift
//  YoutubeApi
//
//  Created by vlad on 5/29/22.
//  Copyright © 2022 Vlad Lazoryk. All rights reserved.
//

import UIKit

class BaseCollectionViewCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
