//
//  ViewModel.swift
//  CycleScrollView
//
//  Created by 白野 on 2019/3/9.
//  Copyright © 2019 白野. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    var collections: [[String: String]]!
    
    func reloadData() {
        self.collections = [["title": "普通样式",
                             "controller": "NormalViewController"],
                            ["title": "列表样式",
                             "controller": "CollectionViewController"],
                            ["title": "列表头样式",
                             "controller": "CollectionReusableViewController"]]
    }
}
